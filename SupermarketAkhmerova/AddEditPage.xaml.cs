using Microsoft.Win32;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace SupermarketAkhmerova
{
    /// <summary>
    /// Логика взаимодействия для AddEditPage.xaml
    /// </summary>
    public partial class AddEditPage : Page
    {
        private Товары currentProduct = new Товары();
        public AddEditPage(Товары selectedProduct )
        {
            InitializeComponent();
            var allProducts = SupermarketEntities.GetContext().Товары.ToList();
            if (selectedProduct != null)
            {
                this.currentProduct = selectedProduct;
                if (currentProduct.Отдел == 1) ComboSection.SelectedIndex = 1;
                else if (currentProduct.Отдел == 2) ComboSection.SelectedIndex = 2;
                else if (currentProduct.Отдел == 3) ComboSection.SelectedIndex = 3;
                else if (currentProduct.Отдел == 4) ComboSection.SelectedIndex = 4;
                else if (currentProduct.Отдел == 5) ComboSection.SelectedIndex = 5;
                else if (currentProduct.Отдел == 6) ComboSection.SelectedIndex = 6;
                else if (currentProduct.Отдел == 7) ComboSection.SelectedIndex = 7;
                else if (currentProduct.Отдел == 8) ComboSection.SelectedIndex = 8;
                else if (currentProduct.Отдел == 9) ComboSection.SelectedIndex = 9;
                else ComboSection.SelectedIndex = 10;
            }
            else
            {
                ComboSection.SelectedIndex = 0;
            }


            DataContext = currentProduct;
        }

        private void ChangePictureBtn_Click(object sender, RoutedEventArgs e)
        {
            OpenFileDialog myOpenFileDialog = new OpenFileDialog();
            if (myOpenFileDialog.ShowDialog() == true)
            {
                currentProduct.Фото_Товары = myOpenFileDialog.FileName;
                ProductPhoto.Source = new BitmapImage(new Uri(myOpenFileDialog.FileName));
            }
        }

        private void SaveBtn_Click(object sender, RoutedEventArgs e)
        {
            if (ComboSection.SelectedIndex == 1) currentProduct.Отдел = 1;
            else if (ComboSection.SelectedIndex == 2) currentProduct.Отдел = 2;
            else if (ComboSection.SelectedIndex == 3) currentProduct.Отдел = 3;
            else if (ComboSection.SelectedIndex == 4) currentProduct.Отдел = 4;
            else if (ComboSection.SelectedIndex == 5) currentProduct.Отдел = 5;
            else if (ComboSection.SelectedIndex == 6) currentProduct.Отдел = 6;
            else if (ComboSection.SelectedIndex == 7) currentProduct.Отдел = 7;
            else if (ComboSection.SelectedIndex == 8) currentProduct.Отдел = 8;
            else if (ComboSection.SelectedIndex == 9) currentProduct.Отдел = 9;
            else if (ComboSection.SelectedIndex == 10) currentProduct.Отдел = 10;
            StringBuilder errors = new StringBuilder();

            if (string.IsNullOrWhiteSpace(NameTB.Text))
                errors.AppendLine("Укажите название товара");
            if (NameTB.Text.Length > 50)
                errors.AppendLine("Название товара не должно быть длиннее 50 символов");
            if (ComboSection.SelectedIndex == 0)
                errors.AppendLine("Укажите отдел");
            if (string.IsNullOrWhiteSpace(CountryTB.Text))
                errors.AppendLine("Укажите страну-производителя");
            if (CountryTB.Text.Length > 50)
                errors.AppendLine("Страна-производитель не должна быть длиннее 50 символов");
            if (StorageConditionTB.Text.Length > 50)
                errors.AppendLine("Условия хранения не должны быть длиннее 50 символов");
            if (ConditionTimeTB.Text.Length > 50)
                errors.AppendLine("Сроки хранения не должны быть длиннее 30 символов");
            if (string.IsNullOrWhiteSpace(PriceTB.Text) || PriceTB.Text == "0")
                errors.AppendLine("Укажите цену");

            if (errors.Length > 0)
            {
                MessageBox.Show(errors.ToString());
                return;
            }
            if (currentProduct.Номер_товара == 0) SupermarketEntities.GetContext().Товары.Add(currentProduct);

            try
            {
                SupermarketEntities.GetContext().SaveChanges();
                MessageBox.Show("Информация сохранена");
                Manager.MainFrame.GoBack();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message.ToString());
            }
        }
    }
}
