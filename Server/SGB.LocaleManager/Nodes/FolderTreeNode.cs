namespace LocaleManager.Nodes
{
    public sealed class FolderTreeNode : TreeNode
    {
        private bool isOpen;
        public bool IsOpen // this exists incase i ever plan to add multi directory support
        {
            get
            {
                return isOpen;
            }
            set
            {
                isOpen = value;
                CheckState();
            }
        }

        private bool requiresSaving;
        public bool RequiresSaving

        {
            get
            {
                return requiresSaving;
            }
            set
            {
                requiresSaving = value;
                CheckState();
            }
        }

        public string FilePath { get; private set; }

        public FolderTreeNode(string path)
        {
            FilePath = path;
            Text = Path.GetFileName(path);
            IsOpen = true;
        }

        private void CheckState()
        {
            if (RequiresSaving)
            {
                SelectedImageIndex = ImageIndex = IsOpen ? 3 : 2;
                return;
            }

            SelectedImageIndex = ImageIndex = IsOpen ? 0 : 1;
        }
    }
}
