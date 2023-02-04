using System.Net;
using System.Net.Sockets;
using SGB.GameServer.Utils;

namespace SGB.GameServer.Core
{
    public sealed class SessionListener : IDisposable
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

        public void Start() => BeginAccept();

        private void BeginAccept()
        {
            if (!AcceptConnections)
                return;
            _ = Socket.BeginAccept(OnAccept, null);
        }

        private void OnAccept(IAsyncResult ar)
        {
            var socket = Socket.EndAccept(ar);

            DebugUtils.Log($"New Session started: {socket}");

            Application.SessionManager.New(socket);

            BeginAccept();
        }

        public void DisableConnections()
        {
            AcceptConnections = false;
        }

        public void Dispose()
        {
            Socket.Close();
        }
    }
}
