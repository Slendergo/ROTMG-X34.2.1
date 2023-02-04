namespace SGB.GameServer.Utils
{
    public static class DebugUtils
    {
        private static readonly object LogLock = new object();

        public static void Log(object? value)
        {
#if DEBUG
            lock (LogLock)
            {
                Console.WriteLine($"[DEBUG | Thread #{Thread.CurrentThread.ManagedThreadId}] {value}");
            }
#endif
        }
    }
}
