using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using Microsoft.AspNet.SignalR;
using Microsoft.AspNet.SignalR.Hubs;
using FinalYearProjectMasterPage.App_Code;

namespace FinalYearProjectMasterPage
{
    public static class UserHandler
    {
        public static HashSet<string> ConnectedIds = new HashSet<string>();
    }

    public class MyHub : Hub
    {
        private static List<GameRoom> gameRooms = new List<GameRoom>();
        private String cGamePin;
        private String ccGamePin;
        private static String status = "";

        public static void Show()
        {
            IHubContext context = GlobalHost.ConnectionManager.GetHubContext<MyHub>();
            context.Clients.All.displayStatus();
        }
        public void Announce(string message)
        {
            Clients.Group(message).Announce("Start");
        }

        public void AddGamePin(string gamePin, string quizID)
        {
            if (!gameRooms.Exists(x => x.GamePin == gamePin))
            {
                GameRoom room = new GameRoom();
                room.Lecturer = Context.ConnectionId;
                room.GamePin = gamePin;
                room.Players = new List<Player>();
                room.currentAnswerCount = 0;
                room.gameID = quizID;
                gameRooms.Add(room); 
                Groups.Add(Context.ConnectionId, gamePin);
                cGamePin = gamePin;
                ccGamePin = gamePin;
            }
        }

        public void Join(string gamePin)
        {
            if (gameRooms.Exists(x => x.GamePin == gamePin))
            {
                GameRoom room = gameRooms.Find(x => x.GamePin == gamePin);
                Player player = new Player(Context.ConnectionId, "", "");
                if (!room.Players.Contains(player))
                {
                    Groups.Add(Context.ConnectionId, gamePin);
                    room.Players.Add(player);
                    Clients.Caller.Notify("Join" + room.gameID);
                }
              
            }
            else
            {
                Clients.Caller.Notify("Invalid Game Pin");
                
            }
        }

        public void AddNickNameToTable(string nickname, string gamePin, string username)
        {
            if (gameRooms.Exists(x => x.GamePin == gamePin))
            {
                GameRoom room = gameRooms.Find(x => x.GamePin == gamePin);
                Player newPlayer = new Player(Context.ConnectionId, "", "");
                if (room.Players.Contains(newPlayer))
                {
                   
                    Player player = room.Players.Find(x => x.ConnectionId == Context.ConnectionId);
                    player.NickName = nickname;
                    player.UserName = username;
                    player.Points = 0;
                    player.Correct = 0;
                    player.answer = new List<AnswerClass>();
                    room.Players.Reverse();
                    Clients.Client(room.Lecturer).Count(room.Players.Count);
                    Clients.Client(room.Lecturer).JoinClient(room.Players);
                    Clients.Caller.Notify("Did you see your name ?");
                    room.Players.Reverse();
                }
            }
        }

        public void DeleteNickNameFromTable(int id, string gamePin)
        {
            if (gameRooms.Exists(x => x.GamePin == gamePin))
            {
                GameRoom room = gameRooms.Find(x => x.GamePin == gamePin);
                room.Players.Reverse();
                Player newPlayer = room.Players[id];
                if (room.Players.Contains(newPlayer))
                {
                    Clients.Client(newPlayer.ConnectionId).Kick();
                    Groups.Remove(newPlayer.ConnectionId, gamePin);
                    room.Players.Remove(newPlayer);
                    Clients.Client(room.Lecturer).Count(room.Players.Count);
                    Clients.Client(room.Lecturer).JoinClient(room.Players);
                }
                room.Players.Reverse();
            }
        }

        public void ReceiveAnswer(string answer, int points, string gamePin)
        {
            GameRoom room = gameRooms.Find(x => x.GamePin == gamePin);
            if (room != null)
            {
                Player newPlayer = room.Players.Find(x => x.ConnectionId == Context.ConnectionId);
                if (newPlayer != null)
                {
                    AnswerClass newAnswer = new AnswerClass();
                    newAnswer.Answer = answer;
                    newPlayer.Points += points;
                    if (points > 0)
                    {
                        newPlayer.Correct += 1;
                        newAnswer.Correctness = "Correct";
                    }
                    else
                    {
                        newAnswer.Correctness = "False";
                    }
                    newPlayer.answer.Add(newAnswer);
                    room.currentAnswerCount += 1;
                    if(room.currentAnswerCount == room.Players.Count())
                    {
                        Clients.Client(room.Lecturer).StopDisplay();
                        Clients.Caller.Notify("stopDisplay");
                    }
                    Clients.Client(room.Lecturer).AnswerCount(room.currentAnswerCount);
                }
            }
        }

        public void RefreshAnswerCount(string gamePin)
        {
            GameRoom room = gameRooms.Find(x => x.GamePin == gamePin);
            if (room != null)
            {
                room.currentAnswerCount = 0;
                Clients.Client(room.Lecturer).AnswerCount(room.currentAnswerCount);
            }
        }

        public void GetAnswerStats(string gamepin, int counter)
        {
            List<string> answers = new List<string>();
            GameRoom room = gameRooms.Find(x => x.GamePin == gamepin);
            if (room != null)
            {
                for (int i = 0; i < room.Players.Count; i++)
                {
                    answers.Add(room.Players[i].answer[counter].Answer);
                }
                Clients.Caller.ReturnAnswer(answers);
            }
        }

        public void GetTopFive(string gamepin)
        {
            GameRoom room = gameRooms.Find(x => x.GamePin == gamepin);
            if (room != null)
            {
                List<Player> top5 = room.Players.OrderByDescending(x => x.Points).Take(5).ToList();
                Clients.Caller.GetTopFive(top5);
            }
        }

        public void NextQuestion(string gamepin)
        {
            Clients.Group(gamepin).NextQuestion();
        }

        public void GetPlayers(string gamepin)
        {
            List<Player> players = null;
            GameRoom room = gameRooms.Find(x => x.GamePin == gamepin);
            if (room != null)
            {
                players = room.Players;
                Clients.Caller.GetPlayers(players.ToArray());

            }
        }

        public override Task OnConnected()
        {
            UserHandler.ConnectedIds.Add(Context.ConnectionId);
            return base.OnConnected();
        }

        public override Task OnDisconnected(bool stopCalled)
        {
            //GameRoom room = gameRooms.Find(x => x.Players.Exists(y => y == Context.ConnectionId));
            GameRoom room = gameRooms.Find(x => x.Players.Exists(y => y.ConnectionId == Context.ConnectionId));
            if (room != null)
            {
                string pin = room.GamePin;
                Player player = room.Players.Find(x => x.ConnectionId == Context.ConnectionId);
                room.Players.Remove(player);
                Groups.Remove(player.ConnectionId, pin);
                room.Players.Reverse();
                Clients.Client(room.Lecturer).Count(room.Players.Count);
                Clients.Client(room.Lecturer).JoinClient(room.Players);
                room.Players.Reverse();
                cGamePin = "";
            }
            GameRoom roomLec = gameRooms.Find(x => x.Lecturer == Context.ConnectionId);
            if(roomLec != null)
            {
                Clients.Group(roomLec.GamePin).Leave();
                gameRooms.Remove(roomLec);
                Groups.Remove(Context.ConnectionId, roomLec.GamePin);
            }
            return base.OnDisconnected(stopCalled);
         
        }



    }
}