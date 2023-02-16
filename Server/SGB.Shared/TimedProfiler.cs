using System;
using System.Diagnostics;

namespace SGB.Shared
{
    public sealed class TimedProfiler : IDisposable
    {
        private string Message { get; }
        private long Start { get; }

        public TimedProfiler(string message)
        {
            Message = message;
            Start = Stopwatch.GetTimestamp();
        }

        public static void Time(string message, Action action)
        {
            var start = Stopwatch.GetTimestamp();

            action?.Invoke();

            var t = Stopwatch.GetElapsedTime(start, Stopwatch.GetTimestamp());
            var s = t.TotalSeconds;
            var ms = t.TotalMilliseconds;
            var us = t.TotalMicroseconds;
            var ns = t.TotalNanoseconds;
            Console.WriteLine($"{message} - Elapsed: {t} ({s}s) ({ms}ms) ({us}us) ({ns}ns)");
        }

        public void Dispose()
        {
            var t = Stopwatch.GetElapsedTime(Start, Stopwatch.GetTimestamp());
            var s = t.TotalSeconds;
            var ms = t.TotalMilliseconds;
            var us = t.TotalMicroseconds;
            var ns = t.TotalNanoseconds;
            Console.WriteLine($"{Message} - Elapsed: {t} ({s}s) ({ms}ms) ({us}us) ({ns}ns)");
        }
    }
}