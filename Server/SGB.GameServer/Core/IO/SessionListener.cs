using SGB.GameServer.Core.Game.Instancing;
using SGB.GameServer.Utils;
using System.Net;
using System.Net.Sockets;

namespace SGB.GameServer.Core.IO
{
    public sealed class SessionListener
    {
        private readonly Application Application;
        private readonly Socket Socket;
        private bool AcceptConnections;

        public SessionListener(Application application, ConfigurationData configurationData)
        {
            Application = application;

            Socket = new Socket(AddressFamily.InterNetwork, SocketType.Stream, ProtocolType.Tcp);
            Socket.SetSocketOption(SocketOptionLevel.Socket, SocketOptionName.ReuseAddress, true);
            Socket.Bind(new IPEndPoint(IPAddress.Any, configurationData.IOConfiguration.Port));
            Socket.Listen(configurationData.IOConfiguration.Backlog);

            AcceptConnections = true;
        }

        public async void Run()
        {
            Logger.LogDebug($"SessionListener is listening.");

            while (AcceptConnections)
            {
                var socket = await Socket.AcceptAsync();

                // is this worth generating a statemachine??? or should i just stay with begin accept?
                Logger.LogDebug($"SocketListener started a new session");

                SessionManager.Add(Application, socket);
            }

            Logger.LogDebug($"SocketListener has stopped running");
            Socket.Close();
        }

        public void DisableConnections()
        {
            if (!AcceptConnections)
                return;
            AcceptConnections = false;
        }
    }
}
