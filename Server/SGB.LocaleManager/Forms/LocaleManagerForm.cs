using LocaleManager.Nodes;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace LocaleManager.Forms
{
    public partial class LocaleManagerForm : Form
    {
        public LocaleManagerForm()
        {
            InitializeComponent();
        }

        private void listBox1_SelectedIndexChanged(object sender, EventArgs e)
        {
            var item = (LocaleTokenValue)listBox1.SelectedItem;
            if (item == null)
                return;
            textBox1.Text = item.Token;
            richTextBox1.Text = item.Value;
        }

        private void button1_Click(object sender, EventArgs e)
        {
            if (listBox1.SelectedIndex == -1)
                return;

            var token = new LocaleTokenValue(textBox1.Text, richTextBox1.Text);

            var node = (FileTreeNode)treeView1.SelectedNode;
            if(node.UpdateToken(token.Token, token.Value))
            {
                listBox1.Items[listBox1.SelectedIndex] = token;
            }
        }

        private void button2_Click(object sender, EventArgs e)
        {
            var token = new LocaleTokenValue(textBox3.Text, richTextBox2.Text);

            var node = (FileTreeNode)treeView1.SelectedNode;
            if (node.AddToken(token.Token, token.Value))
            {
                listBox1.Items.Add(token);
                listBox1.SelectedIndex = listBox1.Items.Count - 1;
            }
        }

        private List<LocaleTokenValue> OriginalList;

        private void textBox2_TextChanged(object sender, EventArgs e)
        {
            if (textBox2.Text.Length == 0)
            {
                foreach (var a in OriginalList)
                    listBox1.Items.Add(a);
                OriginalList = null;
                return;
            }
            filterTimer.Start();
        }

        private void timer1_Tick(object sender, EventArgs e)
        {
            if (OriginalList == null)
                OriginalList = listBox1.Items.Cast<LocaleTokenValue>().ToList();

            listBox1.Items.Clear();
            if (textBox2.Text.Length == 0)
            {
                foreach (var a in OriginalList)
                    listBox1.Items.Add(a);
                OriginalList = null;
            }
            else
            {
                foreach (var b in OriginalList.Where(_ => _.Token.ToLower().Contains(textBox2.Text.ToLower())))
                    listBox1.Items.Add(b);
            }
            filterTimer.Stop();
        }

        private void openToolStripButton_Click(object sender, EventArgs e)
        {
            var selectedNode = treeView1.SelectedNode as FileTreeNode;
            if (selectedNode != null && selectedNode.NeedsSaving)
                if(MessageBox.Show("Are you sure you want to open a new directory location? any unsaved changes will be lost.", "Are you sure?", MessageBoxButtons.YesNo) == DialogResult.No)
                    return;

            var result = folderBrowserDialog1.ShowDialog();
            if (result == DialogResult.OK)
                LoadDirectoryTree(folderBrowserDialog1.SelectedPath);
        }

        private void LoadDirectoryTree(string path)
        {
            if(treeView1.Nodes.Count == 1)
                foreach(var node in treeView1.Nodes[0].Nodes)
                    ((FileTreeNode)node).UnlockFileStream();

            treeView1.Nodes.Clear();
            richTextBox1.Clear();
            richTextBox1.ClearUndo();
            richTextBox2.ClearUndo();
            richTextBox2.Clear();
            textBox1.Clear();
            textBox3.Clear();

            var result = new FolderTreeNode(path);
            result.Expand();

            var files = Directory.EnumerateFiles(path, "*.rlf");
            foreach (var file in files)
                result.Nodes.Add(new FileTreeNode(file));
            treeView1.Nodes.Add(result);
        }

        private void saveToolStripButton_Click(object sender, EventArgs e)
        {
            var selectedNode = treeView1.SelectedNode as FileTreeNode;
            if (selectedNode != null && selectedNode.NeedsSaving)
                selectedNode.Save();
        }

        private void button3_Click(object sender, EventArgs e)
        {
            if(MessageBox.Show("Are you sure you want to delete the token?\nthis can't be un done unless you discard your changes", "Delete token", MessageBoxButtons.YesNo) == DialogResult.Yes)
            {
                var token = (LocaleTokenValue)listBox1.SelectedItem;

                var node = (FileTreeNode)treeView1.SelectedNode;
                if (node.RemoveToken(token.Token))
                {
                    listBox1.Items.Remove(token);
                    listBox1.SelectedIndex = -1;

                    richTextBox1.Clear();
                    richTextBox1.ClearUndo();
                    richTextBox2.ClearUndo();
                    richTextBox2.Clear();
                    textBox1.Clear();
                    textBox3.Clear();

                    if (listBox1.Items.Count > 0)
                        listBox1.SelectedIndex = 0;
                }
            }
        }

        private void LocaleManagerForm_FormClosing(object sender, FormClosingEventArgs e)
        {
            var selectedNode = treeView1.SelectedNode as FileTreeNode;
            if (selectedNode != null && selectedNode.NeedsSaving)
                if (MessageBox.Show("Are you sure you want to quit without saving?", "Pending Changes", MessageBoxButtons.YesNo) == DialogResult.No)
                    e.Cancel = true;
        }

        private void treeView1_BeforeCollapse(object sender, TreeViewCancelEventArgs e)
        {
            e.Cancel = true;
        }

        private void treeView1_BeforeSelect(object sender, TreeViewCancelEventArgs e)
        {
            var currentNode = treeView1.SelectedNode as FileTreeNode;
            if (currentNode != null)
            {
                var selectedNode = e.Node as FileTreeNode;
                if (selectedNode != null)
                {
                    if (!currentNode.CanUnfocus())
                        if (MessageBox.Show("Are you sure you want to change file without saving?", "File not saved", MessageBoxButtons.YesNo) == DialogResult.No)
                        {
                            e.Cancel = true;
                            return;
                        }

                    currentNode.Unfocus();
                    selectedNode.Focus();

                    treeView1.SelectedNode = currentNode;
                }
            }
        }

        private void treeView1_AfterSelect(object sender, TreeViewEventArgs e)
        {
            var selectedNode = e.Node as FileTreeNode;
            if (selectedNode != null)
            {
                richTextBox1.Clear();
                richTextBox1.ClearUndo();
                richTextBox2.ClearUndo();
                richTextBox2.Clear();
                textBox1.Clear();
                textBox3.Clear();

                if (!selectedNode.Loaded)
                    selectedNode.LazilyLoad();

                listBox1.BeginUpdate();
                listBox1.Items.Clear();
                foreach (var token in selectedNode.Tokens)
                    if (token.Key.ToLower().Contains(textBox2.Text.ToLower()))
                        listBox1.Items.Add(new LocaleTokenValue(token.Key, token.Value));
                if (listBox1.Items.Count > 0)
                    listBox1.SelectedIndex = 0;
                listBox1.EndUpdate();
            }
        }

        private void saveToolStripMenuItem_Click(object sender, EventArgs e)
        {

        }

        private void newToolStripButton_Click(object sender, EventArgs e)
        {
            DialogResult result;

            if(treeView1.Nodes.Count == 0)
            {
                result = MessageBox.Show("No directory location selected, do you want to select an directory location?", "Select an Directory Location", MessageBoxButtons.YesNo);
                if (result == DialogResult.No)
                    return;

                result = folderBrowserDialog1.ShowDialog();
                if (result == DialogResult.OK)
                    LoadDirectoryTree(folderBrowserDialog1.SelectedPath);
            }

            var folderNode = treeView1.Nodes[0] as FolderTreeNode;

            var saveFileDialog1 = new SaveFileDialog();
            saveFileDialog1.Filter = "Rotmg Language File|*.rlf";
            saveFileDialog1.Title = "Save as Rotmg Language File";
            saveFileDialog1.FileName = "default";
            saveFileDialog1.InitialDirectory = folderNode.FilePath;

            result = saveFileDialog1.ShowDialog();
            if (result == DialogResult.OK) {

                // If the file name is not an empty string open it for saving.
                if (!string.IsNullOrWhiteSpace(saveFileDialog1.FileName))
                {
                    if (File.Exists(saveFileDialog1.FileName))
                    {
                        _ = MessageBox.Show($"You cannot override a already existing rlf file with the name: {Path.GetFileNameWithoutExtension(saveFileDialog1.FileName)}", "New rtl File Error", MessageBoxButtons.OK);
                        return;
                    }

                    using (var file = File.AppendText(saveFileDialog1.FileName))
                    {
                        file.Write("[]");
                    }

                    var newFileNode = new FileTreeNode(saveFileDialog1.FileName);
                    folderNode.Nodes.Add(newFileNode);
                    treeView1.SelectedNode = newFileNode;
                }
            }
        }
    }
}