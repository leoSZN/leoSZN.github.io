using System;
using System.Threading.Tasks;
using Microsoft.Owin;
using Owin;

[assembly: OwinStartup(typeof(FinalYearProjectMasterPage.StartUp))]

namespace FinalYearProjectMasterPage
{
    public class StartUp
    {
        public void Configuration(IAppBuilder app)
        {
            app.MapSignalR();
        }
    }
}
