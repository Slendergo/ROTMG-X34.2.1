using System.Buffers.Binary;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
using System.Text;

namespace SGB.Benchmark.Tests
{
    public struct IncomingPayload
    {
        public readonly byte Id;
        private byte[] Buffer;
        private int Position;

        public IncomingPayload(byte[] buffer, int offset)
        {
            Buffer = buffer;
            Position += offset;

            Id = ReadByte();
        }

        public byte ReadByte()
        {
            if (Position >= Buffer.Length)
            {
                Console.WriteLine("Exception: " + Position + " " + Buffer.Length);
                return 0;
            }
            return Buffer[Position++];
        }

        public bool ReadBoolean() => Buffer[Position++] != 0;

        public short ReadInt16()
        {
            var value = Unsafe.ReadUnaligned<short>(ref Unsafe.Add(ref MemoryMarshal.GetArrayDataReference(Buffer), Position));
            if (!BitConverter.IsLittleEndian)
                value = BinaryPrimitives.ReverseEndianness(value);
            Position += sizeof(short);
            return value;
        }

        public int ReadInt32()
        {
            var value = Unsafe.ReadUnaligned<int>(ref Unsafe.Add(ref MemoryMarshal.GetArrayDataReference(Buffer), Position));
            if (!BitConverter.IsLittleEndian)
                value = BinaryPrimitives.ReverseEndianness(value);
            Position += sizeof(int);
            return value;
        }

        public long ReadInt64()
        {
            var value = Unsafe.ReadUnaligned<long>(ref Unsafe.Add(ref MemoryMarshal.GetArrayDataReference(Buffer), Position));
            if (!BitConverter.IsLittleEndian)
                value = BinaryPrimitives.ReverseEndianness(value);
            Position += sizeof(long);
            return value;
        }

        public byte[] ReadBytes(int size)
        {
            var bytes = new byte[size];
            System.Buffer.BlockCopy(Buffer, Position, bytes, 0, size);
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
            var value = Encoding.UTF8.GetString(Buffer, Position, size);
            Position += size;
            return value;
        }

        public string ReadUTF32()
        {
            var size = ReadInt32();
            if (size == 0)
                return string.Empty;
            var value = Encoding.UTF8.GetString(Buffer, Position, size);
            Position += size;
            return value;
        }
    }
}
