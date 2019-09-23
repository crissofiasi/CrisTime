using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(CrisTime.Startup))]
namespace CrisTime
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
