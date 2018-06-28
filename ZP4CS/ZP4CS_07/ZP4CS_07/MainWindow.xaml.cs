using System;
using System.Collections.Generic;
using System.IO;
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
using System.Xml.Serialization;

namespace ZP4CS_07
{
    public partial class MainWindow : Window
    {
        private Canvas canvas;
        private Ordered_set loadedSet;
        private TextBlock txtBlck;
        string fullPath = @"E:\GoogleDrive\!UPOL\ZP4CS\ZP4CS_07\lat.xml";
        List<Ellipse> points = new List<Ellipse>();        
        bool txtBxON = false;


        public MainWindow()
        {
            InitializeComponent();
            initCanvas();
            //autoLoadXML();
            //drawPoints();
            //drawLines();
        }

        private void initCanvas()
        {
            canvas = new Canvas();
            MyGrid.Children.Add(canvas);
            canvas.MouseLeftButtonUp += delegate {
                if (txtBxON)
                {
                    canvas.Children.RemoveAt(canvas.Children.Count - 1);
                    txtBxON = false;
                }
                };
        }

        private void addMyText()
        {
            txtBlck = new TextBlock();
            try
            {
                txtBlck.Text = loadedSet.ToString();
                canvas.Children.Add(txtBlck);
                Canvas.SetLeft(txtBlck, 0);
                Canvas.SetTop(txtBlck, 0);

            }
            catch (Exception)
            {
                Console.WriteLine("Je to prazdny");
            }
        }

        private void drawPolygon()
        {
            //canvas.Children.Add(p);

            Polygon myPolygon = new Polygon();
            myPolygon.Stroke = System.Windows.Media.Brushes.Black;
            myPolygon.Fill = System.Windows.Media.Brushes.LightSeaGreen;
            myPolygon.StrokeThickness = 2;
            myPolygon.HorizontalAlignment = HorizontalAlignment.Center;
            myPolygon.VerticalAlignment = VerticalAlignment.Center;

            PointCollection points = new PointCollection();
            try
            {
                foreach (var item in loadedSet.elements)
                {
                    points.Add(new Point(item.x, item.y));
                }
            }
            catch (Exception)
            {
                Console.WriteLine("xml neni nacteno");
            }

            myPolygon.Points = points;
            canvas.Children.Add(myPolygon);
        }

        private void drawPoints()
        {
            for (int i = 0; i < loadedSet.elements.Length; i++)
            {
                Ellipse el = new Ellipse();
                el.Width = 10;
                el.Height = 10;
                el.StrokeThickness = 10;
                el.Stroke = Brushes.Black;
                el.ToolTip = "tool tip";
                points.Add(el);

                ordered_setElement element = loadedSet.elements[i];
                el.MouseDown += delegate (object sender, MouseButtonEventArgs e) {
                    TextBlock txtBlck = new TextBlock();
                    txtBlck.Text = element.objects + "," + element.attributes;
                    canvas.Children.Add(txtBlck);
                    Canvas.SetLeft(txtBlck, e.GetPosition(this).X);
                    Canvas.SetTop(txtBlck, e.GetPosition(this).Y);
                    txtBxON = true;
                };

            }
            foreach (var item in loadedSet.elements)
            {
                Canvas.SetLeft(points.ElementAt((int)item.id - 1), item.x);
                Canvas.SetTop(points.ElementAt((int)item.id - 1), item.y);
                canvas.Children.Add(points.ElementAt((int)item.id - 1));
            }
        }

        private void drawLines()
        {
            foreach (var item in loadedSet.orders)
            {
                Line line = new Line();
                line.Stroke = Brushes.Red;
                line.StrokeThickness = 1;
                line.X1 = Canvas.GetLeft(points.ElementAt(item.bigger - 1)) + 5;
                line.Y1 = Canvas.GetTop(points.ElementAt(item.bigger - 1)) + 5;
                line.X2 = Canvas.GetLeft(points.ElementAt(item.smaller - 1)) + 5;
                line.Y2 = Canvas.GetTop(points.ElementAt(item.smaller - 1)) + 5;
                canvas.Children.Add(line);
            }
        }

        private void autoLoadXML()
        {
            FileStream f = null;
            try
            {
                f = new FileStream(fullPath, FileMode.Open);//do try
                XmlSerializer serializer = new XmlSerializer(typeof(Ordered_set));
                loadedSet = (Ordered_set)serializer.Deserialize(f);
                f.Dispose();

            }
            catch (Exception)
            {
                Console.WriteLine("Chyba pri nacitani XML");
            }
        }

        private void loadFile()
        {

            Microsoft.Win32.OpenFileDialog dialog = new Microsoft.Win32.OpenFileDialog();
            dialog.DefaultExt = ".xml";
            dialog.Filter = "Soubory xml (*.xml)|*.xml";
            Nullable<bool> result = dialog.ShowDialog();
            if (result == true)
            {
                fullPath = dialog.FileName;
                Console.WriteLine(fullPath);
            }
            loadedSet = new Ordered_set();
            FileStream f = null;
            try
            {
                f = new FileStream(fullPath, FileMode.Open);//do try
                XmlSerializer serializer = new XmlSerializer(typeof(Ordered_set));
                loadedSet = (Ordered_set)serializer.Deserialize(f);
                f.Dispose();

            }
            catch (Exception e)
            {
                Console.WriteLine("Chyba pri nacitani XML");
                throw e;
            }
            MessageBox.Show("Load OK", "INFO");
        }

        private void drawPointseee()
        {
            try
            {

            }
            catch (Exception e)
            {
                Console.WriteLine(e);
            }
            foreach (var item in loadedSet.elements)
            {
                Console.WriteLine(item.id);
            }
        }
         
        private void LoadXML_butt_Click(object sender, RoutedEventArgs e)
        {
            loadFile();
            drawPoints();
            drawLines();
        }

        private void ExportPNG_butt_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                RenderTargetBitmap rtb = new RenderTargetBitmap((int)canvas.RenderSize.Width,
                (int)canvas.RenderSize.Height, 96, 96, PixelFormats.Default);
                rtb.Render(canvas);
                BitmapEncoder encoder = new PngBitmapEncoder();
                encoder.Frames.Add(BitmapFrame.Create(rtb));

                Microsoft.Win32.SaveFileDialog saveDialog = new Microsoft.Win32.SaveFileDialog();
                Nullable<bool> result = saveDialog.ShowDialog();
                if (result == true)
                {
                    using (var fs = File.OpenWrite(saveDialog.FileName))
                    {
                        encoder.Save(fs);
                    }
                }
            }
            catch (Exception)
            { MessageBox.Show("Nepovedlo se ulozit soubor", "Chyba"); }
        }
    }
}