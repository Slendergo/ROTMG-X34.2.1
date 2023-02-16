using SGB.GameServer.Core.Game.Instancing;
using SGB.GameServer.Core.IO;
using SGB.GameServer.Utils;

namespace SGB.GameServer.Core
{

    public sealed class Application : IDisposable
    {
        public readonly SessionListener SessionListener;

        public Application(int port)
        {
            SessionListener = new SessionListener(this, port);

            InstanceManager.SpinNewInstance(InstanceType.Nexus, 5, -2);
            InstanceManager.SpinNewInstance(InstanceType.Realm, 2);
        }

        public void Run()
        {
            SessionListener.Run();

            // main thread will be used to handle restarting the server automatically
            // it will also be responsible for everything else in the server thats not world logic

            var mre = new ManualResetEvent(false);
            while (true)
            {
                mre.WaitOne();
            }

            DebugUtils.WriteLine("Application has stopped running");
        }

        public void Dispose()
        {
            SessionManager.Dispose();
        }
    }
}
