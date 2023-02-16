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

        public SessionListener(Application application, int port)
        {
            Application = application;

            Socket = new Socket(AddressFamily.InterNetwork, SocketType.Stream, ProtocolType.Tcp);
            Socket.SetSocketOption(SocketOptionLevel.Socket, SocketOptionName.ReuseAddress, true);
            Socket.Bind(new IPEndPoint(IPAddress.Any, port));
            Socket.Listen(0xFF);

            AcceptConnections = true;
        }

        public async void Run()
        {
            while (AcceptConnections)
            {
                var socket = await Socket.AcceptAsync();

                // is this worth generating a statemachine??? or should i just stay with begin accept?
                DebugUtils.WriteLine($"SocketListener started a new session");

                SessionManager.Add(Application, socket);
            }

            DebugUtils.WriteLine($"SocketListener has stopped running");
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
