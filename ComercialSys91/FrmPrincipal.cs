﻿using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace ComercialSys91
{
    public partial class FrmPrincipal : Form
    {
        public FrmPrincipal()
        {
            InitializeComponent();
            
        }

        private void clientesToolStripMenuItem_Click(object sender, EventArgs e)
        {
            // criar instância do Formulário Cliente
            FrmCliente frmCliente = new FrmCliente();
            // tornando frmCliente filho do Container FrmPrincipal (this)
            frmCliente.MdiParent = this;
            // exibe o formulário de cliente no formprincipal
            frmCliente.Show();
        }

        private void novoToolStripMenuItem_Click(object sender, EventArgs e)
        {
            FrmPedidos frmPedidos = new FrmPedidos();
            frmPedidos.MdiParent = this;
            frmPedidos.Show();
        }

        private void FrmPrincipal_Load(object sender, EventArgs e)
        {
           
            FLogin fLogin = new FLogin();
            fLogin.ShowDialog();
            lb_nome.Text = Program.usuario.Nome;
            if (Program.usuario != null)
            {
                toolStripStatusNivellogado.Text = Program.usuario.Nivel.Sigla + " - " + Program.usuario.Nivel.Nome;
                switch (Program.usuario.Nivel.Sigla)
                {
                    case "gr":
                        this.statusStripMain.BackColor = Color.LightGreen;
                        break;
                    case "at":
                        this.statusStripMain.BackColor = Color.LightYellow;
                        break;
                    case "cx":
                        this.statusStripMain.BackColor = Color.LightBlue;
                        break;
                    default:
                        break;
                }
            }
            
        }

        private void usuáriosToolStripMenuItem_Click(object sender, EventArgs e)
        {
            
            
        }

        private void novoToolStripMenuItem1_Click(object sender, EventArgs e)
        {
            FUsuario fUsuario = new FUsuario();
            fUsuario.MdiParent = this;
            fUsuario.Show();
        }

        private void btn_sair_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void produtosToolStripMenuItem_Click(object sender, EventArgs e)
        {
            FProduto fproduto = new FProduto();
            fproduto.ShowDialog();
        }
    }
}
