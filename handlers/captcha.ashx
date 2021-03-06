﻿<%@ WebHandler Language="C#" Class="captcha" %>

using System;
using System.Web;
using System.Drawing;
using System.Drawing.Imaging;
using IndiaBobbles.Models;
using System.IO;

public class captcha : IHttpHandler
{
    int Width = 50, Height = 25, Length = 6, FontSize = 10, Noise = 20;
    public void ProcessRequest(HttpContext context)
    {
        if (context.Request["noise"] != null && context.Request["noise"] != string.Empty)
        {
            try
            {
                Noise = int.Parse(context.Request["noise"]);
            }
            catch
            {
            }
        }
        if (context.Request["fontsize"] != null && context.Request["fontsize"] != string.Empty)
        {
            try
            {
                FontSize = int.Parse(context.Request["fontsize"]);
            }
            catch
            {
            }
        }
        if (context.Request["width"] != null && context.Request["width"] != string.Empty)
        {
            try
            {
                Width = int.Parse(context.Request["width"]);
            }
            catch
            {
            }
        }
        if (context.Request["height"] != null && context.Request["height"] != string.Empty)
        {
            try
            {
                Height = int.Parse(context.Request["height"]);
            }
            catch
            {
            }
        }

        if (context.Request["length"] != null && context.Request["length"] != string.Empty)
        {
            try
            {
                Length = int.Parse(context.Request["length"]);
            }
            catch
            {
            }
        }

        if (context.Request["key"] != null && context.Request["key"] != string.Empty)
        {
            context.Response.ContentType = "image/gif";
            Bitmap bmp = new Bitmap(Width, Height);
            // Create string to draw.
            String drawString = Guid.NewGuid().ToString().Substring(0, Length);
            if (CacheManager.Get<string>(context.Request["key"].ToString()) == null)
            {
                CacheManager.Add(context.Request["key"].ToString(), drawString, DateTime.Now.AddMinutes(2));
            }
            else
            {
                drawString = CacheManager.Get<string>(context.Request["key"].ToString());
            }
            Graphics g = Graphics.FromImage(bmp); g.Clear(Color.White);

            Font drawFont = new Font("Arial", FontSize);
            SolidBrush drawBrush = new SolidBrush(Color.Black);
            // Create point for upper-left corner of drawing.
            PointF drawPoint = new PointF(0, bmp.Height / 4);

            // Draw string to screen.
            g.DrawString(drawString, drawFont, drawBrush, drawPoint);

            Pen pen = new Pen(Color.Black, 2);
            Point[] points = new Point[] {
                 new Point(10,  10),
                 new Point(10, 100),
                 new Point(200,  50),
                 new Point(250, 300)
             };
            Random r = new Random(0);
            for (int i = 0; i < (Noise); i++)
            {
                Point start = new Point(r.Next(Width), r.Next(Height));
                g.DrawLine(pen, start, new Point(r.Next(start.X - 10, start.X + 10), r.Next(start.Y - 10, start.Y + 10)));
            }

            g.ResetTransform();
            bmp.Save(context.Response.OutputStream, ImageFormat.Gif);
            bmp.Dispose();
            g.Dispose();
        }
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }
}