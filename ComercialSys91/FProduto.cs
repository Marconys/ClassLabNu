﻿using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using ClassLabNu;

namespace ComercialSys91
{
    public partial class FProduto : Form
    {
        public FProduto()
        {
            InitializeComponent();
        }

        private void FrmProduto_Load(object sender, EventArgs e)
        {

        }

        private void btn_Inserir_Click(object sender, EventArgs e)
        {
            try
            {
                Produto produtos =  new Produto(
                tb_descricao.Text,
                tb_unidade.Text,
                tb_codbar.Text,
                Double.Parse(tb_valor.Text),
                Double.Parse(tb_desconto.Text),
                Convert.ToBoolean(cb_disponivel.Checked));

                produtos.Inserir();

                tb_codbar.Clear();
                tb_valor.Clear();
                tb_unidade.Clear();
                tb_descricao.Clear();
                tb_desconto.Clear();

                MessageBox.Show("Produto Inserido com Sucesso");

            }
            catch (Exception ex)
            {

                MessageBox.Show("Erro na Inserção de produtos " + Text, ex.Message);
            }
            
            

        }

        private void btn_consultar_Click(object sender, EventArgs e)
        {

            Produto produto = Produto.ConsultarPorCodbar(tb_codbar.Text);
            
            try
            {
                if (produto.Id > 0)
                {
                    

                    tb_Id.Text = produto.Id.ToString();
                    tb_codbar.Text = produto.Codbar.ToString();
                    tb_unidade.Text = produto.Unidade.ToString();
                    tb_descricao.Text = produto.Descricao.ToString();
                    tb_valor.Text = produto.Valor.ToString();
                    tb_desconto.Text = produto.Desconto.ToString();
                    cb_disponivel.Checked = produto.Descontinuado;
                    

                    string consulta = "Produto " + tb_descricao.Text + " QTD " + tb_unidade.Text + " Unidades " + "Valor R$ " + tb_valor.Text
                        + " Possui desconto de R$ " + tb_desconto.Text;
                    tb_descricao.Text =  consulta;                   

                }
                else
                {
                    MessageBox.Show("Produto Não Encontrado");
                }


            }
            catch (Exception ex)
            {

                MessageBox.Show(Text, ex.Message);
            }
        }

        private void btn_listar_Click(object sender, EventArgs e)
        {
            try
            {
                dgv_produtos.Rows.Clear();
                List<Produto> listadeprodutos = Produto.Listar();
                int cont = 0;
                
                foreach (Produto produtos in listadeprodutos)
                {
                    dgv_produtos.Rows.Add();
                    dgv_produtos.Rows[cont].Cells[0].Value = produtos.Id.ToString();
                    dgv_produtos.Rows[cont].Cells[1].Value = produtos.Descricao.ToString();
                    dgv_produtos.Rows[cont].Cells[2].Value = produtos.Unidade.ToString();
                    dgv_produtos.Rows[cont].Cells[3].Value = produtos.Codbar.ToString();
                    dgv_produtos.Rows[cont].Cells[4].Value = produtos.Valor.ToString();
                    dgv_produtos.Rows[cont].Cells[5].Value = produtos.Desconto.ToString();
                    dgv_produtos.Rows[cont].Cells[6].Value = produtos.Descontinuado;

                    // Condição que retornar com a disponibilidade do produto listado
                    if (produtos.Descontinuado)
                    {
                        dgv_produtos.Rows[cont].Cells[6].Value = "Disponível";
                    }
                    else
                    {
                        dgv_produtos.Rows[cont].Cells[6].Value = "Indisponível";
                    }

                    cont++;


                    
                }

                

            }
            catch (Exception ex )
            {

                MessageBox.Show(Text, ex.Message);
            }
            
        }

        private void dgv_produtos_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            
        }

        private void cb_disponivel_CheckedChanged(object sender, EventArgs e)
        {

        }

        private void cb_disponivel_CheckStateChanged(object sender, EventArgs e)
        {

        }
    }
}
