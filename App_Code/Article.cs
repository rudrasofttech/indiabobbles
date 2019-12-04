using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;
using System.Web.Security;

namespace IndiaBobbles.Models
{
    public class Article
    {
        public long ID { get; set; }
        public string Title { get; set; }
        public string MetaTitle { get; set; }
        public string OGImage { get; set; }
        public string OGDescription { get; set; }
        public DateTime DateCreated { get; set; }
        public DateTime? DateModified { get; set; }
        public long CreatedBy { get; set; }
        public string CreatedByName { get; set; }
        public long? ModifiedBy { get; set; }
        public string ModifiedByName { get; set; }
        public int Category { get; set; }
        public string Tag { get; set; }
        public string CategoryName { get; set; }
        public PostStatusType Status { get; set; }
        public string Description { get; set; }
        public string Text { get; set; }
        public string TemplateName { get; set; }
        public string WriterName { get; set; }
        public string WriterEmail { get; set; }
        public int Viewed { get; set; }
        public string URL { set; get; }
        public bool Sitemap { get; set; }

        public Article()
        {
            TemplateName = string.Empty;
            Status = PostStatusType.Draft;
            WriterEmail = string.Empty;
            WriterName = string.Empty;
            OGImage = string.Empty;
            OGDescription = string.Empty;
            ModifiedByName = string.Empty;
            Viewed = 0;
            URL = string.Empty;
            Sitemap = true;
            MetaTitle = string.Empty;
        }
    }
}