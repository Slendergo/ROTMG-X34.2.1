using SGB.GameServer.Core.Game.Instancing;
using SGB.GameServer.Core.IO;
using SGB.GameServer.Utils;
using System;
using System.Threading;

namespace SGB.GameServer.Core
{
    public sealed class Application : IDisposable
    {
        public readonly SessionListener SessionListener;

        public Application(ConfigurationData configurationData)
        {
            SessionListener = new SessionListener(this, configurationData);

            InstanceManager.SpinNewInstance(InstanceType.Nexus, 5);
            //for(var i = 0; i < configurationData.RealmConfiguration.StartingRealms; i++)
            //    InstanceManager.SpinNewInstance(InstanceType.Realm, 5);
        }

        public void Run()
        {
            SessionListener.Run();

            // main thread will be used to handle restarting the server automatically
            // it will also be responsible for everything else in the server thats not world logic

            Logger.LogDebug("Application Running");

            var mre = new ManualResetEvent(false);
            while (true)
            {
                _ = mre.WaitOne();
            }

            Logger.LogDebug("Application has stopped running");
        }

        public void Dispose()
        {
            InstanceManager.Dispose();
            SessionManager.Dispose();
        }
    }
}
