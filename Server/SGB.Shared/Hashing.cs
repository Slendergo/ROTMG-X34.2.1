using System.Security.Cryptography;
using System.Text;

namespace SGB.Shared
{
    public static class Hashing
    {
        public static string GetHashedPassword(string password)
        {
            var salt = password[..(password.Length / 2)];

            var sb = new StringBuilder();

            using var md5 = MD5.Create();

            var computedBuffer = md5.ComputeHash(Encoding.UTF8.GetBytes(password));
            var buffer = md5.ComputeHash(Encoding.UTF8.GetBytes(salt));

            for (var i = 0; i < buffer.Length; i++)
                _ = sb.Append(buffer[i].ToString("X2"));
            for (var i = 0; i < computedBuffer.Length; i++)
                _ = sb.Append(computedBuffer[i].ToString("X2"));
            for (var i = buffer.Length - 1; i >= 0; i--)
                if (i % 2 == 0)
                    _ = sb.Append(buffer[i].ToString("X2"));
            return sb.ToString();
        }
    }
}