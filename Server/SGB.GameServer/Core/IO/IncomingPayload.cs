using System;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
using System.Text;

namespace SGB.GameServer.Core.IO
{
    public struct IncomingPayload
    {
        public int Position;
        private readonly Memory<byte> Buffer;
        public int Size => Buffer.Length;

        public IncomingPayload(Memory<byte> buffer, int offset)
        {
            Buffer = buffer;
            Position = offset;
        }

        public byte ReadByte() => Buffer.Span[Position++];
        public bool ReadBoolean() => Buffer.Span[Position++] != 0;

        public short ReadInt16()
        {
            var value = Unsafe.ReadUnaligned<short>(ref Unsafe.Add(ref MemoryMarshal.GetReference(Buffer.Span), Position));
            Position += sizeof(short);
            return value;
        }

        public int ReadInt32()
        {
            var value = Unsafe.ReadUnaligned<int>(ref Unsafe.Add(ref MemoryMarshal.GetReference(Buffer.Span), Position));
            Position += sizeof(int);
            return value;
        }

        public long ReadInt64()
        {
            var value = Unsafe.ReadUnaligned<long>(ref Unsafe.Add(ref MemoryMarshal.GetReference(Buffer.Span), Position));
            Position += sizeof(long);
            return value;
        }

        public Span<byte> ReadBytes(int size)
        {
            Span<byte> bytes = new byte[size];
            Unsafe.CopyBlockUnaligned(ref MemoryMarshal.GetReference(bytes), ref Unsafe.Add(ref MemoryMarshal.GetReference(Buffer.Span), Position), Unsafe.As<int, uint>(ref size));
            Position += size;
            return bytes;
        }

        public float ReadFloat()
        {
            var value = ReadInt32();
            return Unsafe.As<int, float>(ref value);
        }

        public double ReadDouble()
        {
            var value = ReadInt64();
            return Unsafe.As<long, double>(ref value);
        }

        // these can probably be optimized?
        public string ReadUTF16()
        {
            var size = ReadInt16();
            if (size == 0)
                return string.Empty;

            Span<byte> bytes = stackalloc byte[size];
            Unsafe.CopyBlockUnaligned(ref MemoryMarshal.GetReference(bytes), ref Unsafe.Add(ref MemoryMarshal.GetReference(Buffer.Span), Position), Unsafe.As<short, uint>(ref size));
            Position += size;
            return Encoding.UTF8.GetString(bytes);
        }

        public string ReadUTF32()
        {
            var size = ReadInt32();
            if (size == 0)
                return string.Empty;

            Span<byte> bytes = stackalloc byte[size];
            Unsafe.CopyBlockUnaligned(ref MemoryMarshal.GetReference(bytes), ref Unsafe.Add(ref MemoryMarshal.GetReference(Buffer.Span), Position), Unsafe.As<int, uint>(ref size));
            Position += size;
            return Encoding.UTF8.GetString(bytes);
        }
    }
}
