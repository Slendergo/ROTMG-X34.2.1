using System;

namespace SGB.GameServer.Utils
{
    public static class DebugUtils
    {
        private static readonly object LogLock = new object();

        public static void WriteLine(object value)
        {
#if DEBUG
            lock (LogLock)
            {
                Console.WriteLine($"[DEBUG | Thread #{Environment.CurrentManagedThreadId}] {value}");
            }
#endif
        }
    }
}
