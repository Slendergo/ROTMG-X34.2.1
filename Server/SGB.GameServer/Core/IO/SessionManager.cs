using System.Net.Sockets;

namespace SGB.GameServer.Core.IO
{
    public static class SessionManager
    {
        private static readonly Dictionary<Guid, Session> Sessions = new Dictionary<Guid, Session>();

        public static void Add(Application application, Socket socket)
        {
            var session = new Session(application, socket);
            lock (Sessions)
            {
                Sessions.Add(session.Id, session);
            }
            session.Start();
        }

        public static void Foreach(Action<Session> action)
        {
            if (action == null)
                throw new ArgumentNullException(nameof(action));

            lock (Sessions)
            {
                foreach (var session in Sessions.Values)
                    action.Invoke(session);
            }
        }

        public static void Remove(Session session)
        {
            lock (Sessions)
            {
                if (Sessions.Remove(session.Id))
                    session.Stop();
            }
        }

        public static void Dispose()
        {
            lock (Sessions)
            {
                foreach (var session in Sessions.Values)
                    session.Stop();
                Sessions.Clear();
            }
        }
    }
}
