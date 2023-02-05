using System.Net.Sockets;

namespace SGB.GameServer.Core.IO
{
    public sealed class SessionManager : IDisposable
    {
        public Dictionary<Guid, Session> Sessions { get; private set; }

        private readonly Application Application;

        public SessionManager(Application application)
        {
            Application = application;
            Sessions = new Dictionary<Guid, Session>();
        }

        public void New(Socket socket)
        {
            var session = new Session(Application, socket);
            Sessions.Add(session.Id, session);
            session.Start();
        }

        public void TrySendTo(ref Guid id, byte[] buffer)
        {
            if (!Sessions.TryGetValue(id, out var session))
                return;
            session.IOManager.Send(buffer);
        }

        public void Remove(Session session)
        {
            if (Sessions.Remove(session.Id))
                session.Stop();
        }

        public void Dispose()
        {
            // stop incase
            foreach (var session in Sessions.Values)
                session.Stop();
            Sessions.Clear();
        }
    }
}
