using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace FinalYearProjectMasterPage.App_Code
{
    public class GameRoom
    {
        public string GamePin { get; set; }

        public string Lecturer { get; set; }

        public List<Player> Players { get; set; }

        public int currentAnswerCount { get; set; }

        public string gameID { get; set; }

        public void addUser(Player player)
        {
            Players.Add(player);
        }
    }
}