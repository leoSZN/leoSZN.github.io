using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace FinalYearProjectMasterPage.App_Code
{
    public class Player : IEquatable<Player>
    {
        public string ConnectionId { get; set; }
        public string UserName { get; set; }
        public string NickName { get; set; }
        public int Points { get; set; }
        public int Correct { get; set; }
        public List<AnswerClass> answer { get; set; }

        public Player()
        {

        }
        public Player(string connectionId, string userName, string nickName)
        {
            this.ConnectionId = connectionId;
            this.UserName = userName;
            this.NickName = nickName;
        }

        public override bool Equals(object obj)
        {
            if (obj == null) return false;
            Player objAsPlayer = obj as Player;
            if (objAsPlayer == null) return false;
            else return Equals(objAsPlayer);
        }
        public bool Equals(Player other)
        {
            if (other == null) return false;
            return (this.ConnectionId.Equals(other.ConnectionId));
        }
    }
}