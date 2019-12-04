using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace IndiaBobbles.Models
{

    public class PostPageModel
    {
        public Article Item { get; set; }
        
        public PostPageModel()
        {
            Item = new Article();
        }
    }
}