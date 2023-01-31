using System.Text;
using System.Text.Json;

namespace LocaleManager.Nodes
{
    public sealed class FileTreeNode : TreeNode
    {
        public enum FileState
        {
            Default,
            Selected,
            ModifiedUnsaved
        }

        private FileState state;
        public FileState State
        {
            get
            {
                return state;
            }
            set
            {
                state = value;
                switch (state)
                {
                    case FileState.Default:
                        SelectedImageIndex = ImageIndex = 4;
                        break;
                    case FileState.Selected:
                        SelectedImageIndex = ImageIndex = 5;
                        break;
                    case FileState.ModifiedUnsaved:
                        SelectedImageIndex = ImageIndex = 6;
                        break;
                }

                NeedsSaving = state == FileState.ModifiedUnsaved;
            }
        }

        public string Locale { get; private set; }
        public bool NeedsSaving { get; private set; }
        public Dictionary<string, string> Tokens { get; private set; } = new Dictionary<string, string>();
        private Dictionary<string, string> LoadedTokens = new Dictionary<string, string>();

        private FileStream FileStream;
        private string FilePath;

        public FileTreeNode(string filePath)
        {
            FilePath = filePath;
            Text = Path.GetFileName(filePath);
            State = FileState.Default;

            // grab a lock on the file asap to prevent deleting
            FileStream = new FileStream(FilePath, FileMode.Open, FileAccess.ReadWrite, FileShare.Read);
        }

        public void Focus()
        {
            State = FileState.Selected;
        }

        public bool CanUnfocus() => State != FileState.ModifiedUnsaved;

        public void Unfocus()
        {
            State = FileState.Default;
            Tokens = new Dictionary<string, string>(LoadedTokens);
        }

        public bool Loaded { get; private set; }
        public void LazilyLoad()
        {
            if (Loaded)
                return;
            Loaded = true;

            using var reader = new StreamReader(FileStream, leaveOpen: true);

            var data = JsonSerializer.Deserialize<string[][]>(reader.ReadToEnd());
            foreach (var tokenValue in data)
            {
                Tokens.Add(tokenValue[0], tokenValue[1]);
                LoadedTokens.Add(tokenValue[0], tokenValue[1]);
            }

            Locale = Path.GetFileNameWithoutExtension(FilePath);

            State = FileState.Selected;
        }

        public bool AddToken(string token, string value)
        {
            var success = Tokens.TryAdd(token, value);
            if (success)
                State = FileState.ModifiedUnsaved;
            return success;
        }

        public bool UpdateToken(string token, string value)
        {
            if (Tokens.ContainsKey(token))
            {
                Tokens[token] = value;
                State = FileState.ModifiedUnsaved;
                return true;
            }
            return false;
        }

        public bool RemoveToken(string token)
        {
            var success = Tokens.Remove(token);
            if (success)
                State = FileState.ModifiedUnsaved;
            return success;
        }

        public void Save()
        {
            var data = new List<string[]>();

            foreach (var tokenValue in Tokens)
                data.Add(new string[3] { tokenValue.Key, tokenValue.Value, Locale});

            var json = JsonSerializer.Serialize(data);
            var buffer = Encoding.UTF8.GetBytes(json);

            FileStream.SetLength(0);
            FileStream.Flush();
            FileStream.Write(buffer, 0, buffer.Length);
            FileStream.Flush();

            LoadedTokens = new Dictionary<string, string>(Tokens);

            State = FileState.Selected;
        }

        public void UnlockFileStream() => FileStream.Close();
    }
}