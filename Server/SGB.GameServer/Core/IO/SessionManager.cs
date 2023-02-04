using System.Net.Sockets;

namespace SGB.GameServer.Core.IO
{
    public sealed class SessionManager : IDisposable
    {
        public Dictionary<Guid, Session> Sessions = new Dictionary<Guid, Session>();

        private readonly Application Application;

        public SessionManager(Application application)
        {
            Application = application;
        }

        public void New(Socket socket)
        {
            var session = new Session(socket);
            Sessions.Add(session.Id, session);
            session.Start();
        }

        public void TrySendTo(ref Guid id, byte[] buffer)
        {
            if (!Sessions.TryGetValue(id, out var session))
                return;
            session.Send(buffer);
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
