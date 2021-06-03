using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Xml.Serialization;
using System.IO;
using IndiaBobbles.Models;
using System.Text.RegularExpressions;

namespace IndiaBobbles
{
    public class Utility
    {
        #region WebsiteSetting
        public static string SiteLogo
        {
            get
            {
                return GetSiteSetting("SiteLogo");
            }
        }

        public static string ContactEmail
        {
            get
            {
                return GetSiteSetting("ContactEmail");
            }
        }

        public static string Fax
        {
            get
            {
                return GetSiteSetting("Fax");
            }
        }

        public static string Phone
        {
            get
            {
                return GetSiteSetting("Phone");
            }
        }

        public static string Address
        {
            get
            {
                return GetSiteSetting("Address");
            }
        }

        public static string SiteName
        {
            get
            {
                return GetSiteSetting("SiteName");
            }
        }

        public static string SiteURL
        {
            get
            {
                return GetSiteSetting("SiteURL");
            }
        }

        public static string UniversalPassword
        {
            get
            {
                return GetSiteSetting("UniversalPassword");
            }
        }

        public static string NewsletterEmail
        {
            get
            {
                return GetSiteSetting("NewsletterEmail");
            }
        }

        public static string AdminName
        {
            get
            {
                return GetSiteSetting("AdminName");
            }
        }

        public static string SiteTitle
        {
            get
            {
                return GetSiteSetting("SiteTitle");
            }
        }

        public static string NewsletterDesign()
        {
            return GetSiteSetting("NewsletterDesign");
        }

        public static string ImageFormat()
        {
            return ".bmp,.dds,.dng,.gif,.jpg,.png,.psd,.psd,.pspimage,.tga,.thm,.tif,.yuv,.ai,.eps,.ps,.svg";
        }

        public static string VideoFormat()
        {
            return ".3g2,.3gp,.asf,.asx,.flv,.mov,.mp4,.mpg,.rm,.srt,.swf,.vob,.wmv";
        }

        public static string TextFormat()
        {
            return ".doc,.docx,.log,.msg,.odt,.pages,.rtf,.tex,.txt,.wpd,.wps";
        }

        public static string CompresssedFormat()
        {
            return ".7z,.cbr,.deb,.gz,.pkg,.rar,.rpm,.sit,.sitx,.tar.gz,.zip,.zipx";
        }
        #endregion

        #region Important Folder Paths
        public static string ArticleFolder
        {
            get
            {
                return "~/sitedata/Article";
            }
        }

        public static string CustomPageFolder
        {
            get
            {
                return "~/sitedata/CustomPage";
            }
        }

        public static string SiteDriveFolderPath
        {
            get
            {
                return string.Format("~/{0}", SiteDriveFolderName);
            }
        }

        public static string SiteDriveFolderName
        {
            get
            {
                return "drive";
            }
        }
        #endregion

        #region Serialization helper functions
        public static T Deserialize<T>(string obj)
        {
            // Create a new file stream for reading the XML file
            XmlSerializer SerializerObj = new XmlSerializer(typeof(T));
            // Load the object saved above by using the Deserialize function
            T LoadedObj = (T)SerializerObj.Deserialize(new StringReader(obj));

            return LoadedObj;
        }

        public static string Serialize<T>(T obj)
        {
            // Create a new XmlSerializer instance with the type of the test class
            XmlSerializer SerializerObj = new XmlSerializer(typeof(T));

            // Create a new file stream to write the serialized object to a file
            TextWriter WriteFileStream = new StringWriter();
            SerializerObj.Serialize(WriteFileStream, obj);

            // Cleanup
            return WriteFileStream.ToString();
        }
        #endregion

        #region General Report Functions
        public static int GetArticleCount()
        {
            if (CacheManager.Get<int?>("ArticleCount") == null)
            {

                using (IndiaBobblesDataClassesDataContext dc = new IndiaBobblesDataClassesDataContext())
                {
                    CacheManager.Add("ArticleCount", (from t in dc.Posts where t.Status != (byte)PostStatusType.Inactive select t).Count(), DateTime.Now.AddMinutes(10));
                }
            }
            return CacheManager.Get<int?>("ArticleCount").Value;
        }

        public static int GetOrderCount()
        {
            if (CacheManager.Get<int?>("OrderCount") == null)
            {

                using (IndiaBobblesDataClassesDataContext dc = new IndiaBobblesDataClassesDataContext())
                {
                    CacheManager.Add("OrderCount", (from t in dc.Orders where t.Status != (byte)OrderStatusType.New select t).Count(), DateTime.Now.AddMinutes(2));
                }
            }
            return CacheManager.Get<int?>("OrderCount").Value;
        }

        public static int GetNewOrderCount()
        {
            if (CacheManager.Get<int?>("NewOrderCount") == null)
            {

                using (IndiaBobblesDataClassesDataContext dc = new IndiaBobblesDataClassesDataContext())
                {
                    CacheManager.Add("NewOrderCount", (from t in dc.Orders where t.Status == (byte)OrderStatusType.Process select t).Count(), DateTime.Now.AddMinutes(2));
                }
            }
            return CacheManager.Get<int?>("NewOrderCount").Value;
        }

        public static int GetCustomPageCount()
        {
            if (CacheManager.Get<int?>("CustomPageCount") == null)
            {

                using (IndiaBobblesDataClassesDataContext dc = new IndiaBobblesDataClassesDataContext())
                {
                    CacheManager.Add("CustomPageCount", (from t in dc.CustomPages where t.Status != (byte)PostStatusType.Inactive select t).Count(), DateTime.Now.AddMinutes(10));
                }
            }
            return CacheManager.Get<int?>("CustomPageCount").Value;
        }

        public static int GetMemberCount()
        {
            if (CacheManager.Get<int?>("MemberCount") == null)
            {

                using (IndiaBobblesDataClassesDataContext dc = new IndiaBobblesDataClassesDataContext())
                {
                    CacheManager.Add("MemberCount", (from t in dc.Members where t.Status == (byte)GeneralStatusType.Active select t).Count(), DateTime.Now.AddMinutes(50));
                }
            }
            return CacheManager.Get<int?>("MemberCount").Value;
        }
        #endregion

        #region Lookup data functions
        public static List<Category> CategoryList()
        {
            if (CacheManager.Category.Count == 0)
            {
                using (IndiaBobblesDataClassesDataContext dc = new IndiaBobblesDataClassesDataContext())
                {
                    CacheManager.Category = (from t in dc.Categories select t).ToList<Category>();
                }
            }
            return CacheManager.Category;
        }

        public static string GetSiteSetting(string keyname)
        {
            if (CacheManager.Get<string>(keyname) == null)
            {
                using (IndiaBobblesDataClassesDataContext dc = new IndiaBobblesDataClassesDataContext())
                {
                    CacheManager.Add(keyname, (from t in dc.WebsiteSettings where t.KeyName == keyname select t.KeyValue).SingleOrDefault(), DateTime.Now.AddDays(7));
                }
            }
            return CacheManager.Get<string>(keyname);
        }
        #endregion

        #region URL purifier functions
        public static string RemoveAccent(string txt)
        {
            byte[] bytes = System.Text.Encoding.GetEncoding("Cyrillic").GetBytes(txt);
            return System.Text.Encoding.ASCII.GetString(bytes);
        }

        public static string Slugify(string phrase)
        {
            string str = RemoveAccent(phrase).ToLower();
            str = System.Text.RegularExpressions.Regex.Replace(str, @"[^a-z0-9/\s-]", ""); // Remove all non valid chars          
            str = System.Text.RegularExpressions.Regex.Replace(str, @"\s+", " ").Trim(); // convert multiple spaces into one space  
            str = System.Text.RegularExpressions.Regex.Replace(str, @"\s", "-"); // //Replace spaces by dashes
            return str;
        }
        #endregion

        #region Blog Function
        /// <summary>
        /// Generate a blog article url. Generated URL will be ~/blog/{title}/{id}
        /// </summary>
        /// <param name="a">Article</param>
        /// <returns></returns>
        public static string GenerateBlogArticleURL(Article a, string root)
        {
            return string.Format("{1}/blog/{0}", a.URL, root);
        }

        public static int GetCategoryArticleCount(Category c)
        {
            if (CacheManager.Get<int?>(string.Format("CategoryArticleCount{0}", c.ID)) == null)
            {
                using (IndiaBobblesDataClassesDataContext dc = new IndiaBobblesDataClassesDataContext())
                {
                    CacheManager.Add(string.Format("CategoryArticleCount{0}", c.ID), (from t in dc.Posts
                                                                                      where t.Status == (byte)PostStatusType.Publish &&
                                                                                          t.Category == c.ID
                                                                                      select t).Count(), DateTime.Now.AddMinutes(10));
                }
            }
            return CacheManager.Get<int?>(string.Format("CategoryArticleCount{0}", c.ID)).Value;
        }
        #endregion

        #region Validation Functions
        public static bool ValidateEmail(string email)
        {
            string pattern = @"\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*";
            Regex regex = new Regex(pattern, RegexOptions.IgnoreCase);
            return regex.IsMatch(email);
        }

        public static bool ValidateRequired(string input)
        {
            if (input.Trim() == string.Empty)
            {
                return false;
            }
            else { return true; }
        }
        #endregion
    }


    public class FilterQueryParser
    {
        private List<List<string>> words;
        public StructuredQuery squery;
        public FilterQueryParser()
        {
            words = new List<List<string>>();
            squery = new StructuredQuery();
        }
        public void Parse(string query)
        {
            string[] lines = query.Trim().Split(";".ToCharArray());
            for (int i = 0; i < lines.Length; i++)
            {
                string line = lines[i];
                if (!string.IsNullOrEmpty(line))
                {
                    string[] temp = line.Trim().Split(" ".ToCharArray());
                    List<string> linelist = new List<string>();
                    for (int j = 0; j < temp.Length; j++)
                    {
                        string w = temp[j];
                        linelist.Add(w.ToLower());
                    }
                    if (linelist.Count > 0)
                    {
                        words.Add(linelist);
                    }
                }
            }
            foreach (List<string> line in words)
            {
                if (line[0] == "find")
                {
                    if (line[1] != "all")
                    {
                        int temp;
                        if (int.TryParse(line[1], out temp))
                        {
                            squery.Take = temp;
                        }

                    }
                }
                else if (line[0] == "sort")
                {
                    if (line.Count == 4)
                    {
                        squery.Sorters.Add(new SortParam() { Column = line[2], Direction = line[3] });
                    }
                }
                else if (line[0] == "where")
                {
                    bool iscolumnset = false;
                    FilterParam fp = new FilterParam();
                    foreach (string w in line)
                    {

                        if (w.StartsWith("\"") && !iscolumnset)
                        {
                            fp.Column = w.Trim("\"".ToCharArray());
                            iscolumnset = true;
                        }
                        else if (w == "is" || w == "isnot" || w == "startswith" || w == "endswith" || w == "contains")
                        {
                            if (iscolumnset)
                            {
                                fp.Operator = w;
                            }
                        }
                        else if (w == "and")
                        {
                            squery.Filters.Add(fp);
                            fp = new FilterParam();
                            iscolumnset = false;
                        }
                        else if (w == "where")
                        {
                            continue;
                        }
                        else
                        {
                            if (iscolumnset)
                            {
                                fp.Value = w.Trim("\"".ToCharArray());
                            }
                        }
                    }
                    if(!string.IsNullOrEmpty(fp.Column) && !string.IsNullOrEmpty(fp.Value))
                    {
                        squery.Filters.Add(fp);
                    }
                }
            }
        }
    }
    public class StructuredQuery
    {
        public int Take { get; set; }
        public List<FilterParam> Filters { get; set; }
        public List<SortParam> Sorters { get; set; }
        public StructuredQuery()
        {
            Take = -1;
            Filters = new List<FilterParam>();
            Sorters = new List<SortParam>();
        }

    }
    public struct FilterParam
    {
        public string Column { get; set; }
        public string Operator { get; set; }
        public string Value { get; set; }
    }

    public struct SortParam
    {
        public string Column { get; set; }
        public string Direction { get; set; }
    }
}