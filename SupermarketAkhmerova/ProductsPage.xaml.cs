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
    /// Логика взаимодействия для ProductsPage.xaml
    /// </summary>
    public partial class ProductsPage : Page
    {
        public ProductsPage()
        {
            InitializeComponent();
            var currentProducts = SupermarketEntities.GetContext().Товары.ToList();
            ProductListView.ItemsSource = currentProducts;
            FilterBox.SelectedIndex = 0;
            SortBox.SelectedIndex = 0;
            UpdateProducts();
        }

        public void UpdateProducts()
        {
            var currentProducts = SupermarketEntities.GetContext().Товары.ToList();
            currentProducts = currentProducts.Where(p => p.Название_товара.ToLower().Contains(SearchTextBox.Text.ToLower())).ToList();

            switch (FilterBox.SelectedIndex)
            {
                case 1:
                    currentProducts = currentProducts.Where(p => (p.Отдел == 1)).ToList();
                    break;
                case 2:
                    currentProducts = currentProducts.Where(p => (p.Отдел == 2)).ToList();
                    break;
                case 3:
                    currentProducts = currentProducts.Where(p => (p.Отдел == 3)).ToList();
                    break;
                case 4:
                    currentProducts = currentProducts.Where(p => (p.Отдел == 4)).ToList();
                    break;
                case 5:
                    currentProducts = currentProducts.Where(p => (p.Отдел == 5)).ToList();
                    break;
                case 6:
                    currentProducts = currentProducts.Where(p => (p.Отдел == 6)).ToList();
                    break;
                case 7:
                    currentProducts = currentProducts.Where(p => (p.Отдел == 7)).ToList();
                    break;
                case 8:
                    currentProducts = currentProducts.Where(p => (p.Отдел == 8)).ToList();
                    break;
                case 9:
                    currentProducts = currentProducts.Where(p => (p.Отдел == 9)).ToList();
                    break;
                case 10:
                    currentProducts = currentProducts.Where(p => (p.Отдел == 10)).ToList();
                    break;
                default:
                    ProductListView.ItemsSource = currentProducts;
                    break;
            }

            if (SortBox.SelectedIndex == 0) currentProducts = currentProducts.ToList();
            if (SortBox.SelectedIndex == 1) currentProducts = currentProducts.OrderBy(p => p.Цена).ToList();
            if (SortBox.SelectedIndex == 2) currentProducts = currentProducts.OrderByDescending(p => p.Цена).ToList();

            ProductListView.ItemsSource = currentProducts;

            TBCount.Text = currentProducts.Count.ToString();

        }

        private void EditButton_Click(object sender, RoutedEventArgs e)
        {
            Manager.MainFrame.Navigate(new AddEditPage((sender as Button).DataContext as Товары));
            UpdateProducts();
        }

        private void ProductListView_IsVisibleChanged(object sender, DependencyPropertyChangedEventArgs e)
        {
            if (Visibility == Visibility.Visible)
            {
                SupermarketEntities.GetContext().ChangeTracker.Entries().ToList().ForEach(p => p.Reload());
                ProductListView.ItemsSource = SupermarketEntities.GetContext().Товары.ToList();
                UpdateProducts();
                var currentProducts = SupermarketEntities.GetContext().Товары.ToList();
                TBAllRecords.Text = " из " + currentProducts.Count.ToString();
            }
        }

        private void MenuItem_Click(object sender, RoutedEventArgs e)
        {
            var currentProductSales = SupermarketEntities.GetContext().Продажи_товаров.ToList();
            var currentProduct = ProductListView.SelectedItem as Товары;
            var currentSales = currentProductSales.Where(p => p.Товар == currentProduct.Номер_товара).ToList();
            if (currentSales.Count != 0)
                MessageBox.Show("Невозможно выполнить удаление, так как существует информация о продажах товара");

            else
            {
                if (MessageBox.Show("Вы точно хотите выполнить удаление?", "Внимание!",
                MessageBoxButton.YesNo, MessageBoxImage.Question) == MessageBoxResult.Yes)
                {
                    try
                    {
                        SupermarketEntities.GetContext().Товары.Remove(currentProduct);
                        SupermarketEntities.GetContext().SaveChanges();

                        UpdateProducts(); 
                        var currentProducts = SupermarketEntities.GetContext().Товары.ToList();
                        TBAllRecords.Text = " из " + currentProducts.Count.ToString();

                    }
                    catch (Exception ex)
                    {
                        MessageBox.Show(ex.Message.ToString());
                    }
                }
                UpdateProducts();
            }
        }

        private void SortBox_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            UpdateProducts();
        }

        private void FilterBox_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            UpdateProducts();
        }

        private void SearchTextBox_TextChanged(object sender, TextChangedEventArgs e)
        {
            UpdateProducts();
        }

        private void AddButton_Click(object sender, RoutedEventArgs e)
        {
            Manager.MainFrame.Navigate(new AddEditPage(null));
            UpdateProducts();
        }
    }
}
