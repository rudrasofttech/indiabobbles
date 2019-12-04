using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace IndiaBobbles.Models
{
    public class MemberManager
    {
        public static bool ValidateUser(string username, string password)
        {
            try
            {
                using (IndiaBobblesDataClassesDataContext dc = new IndiaBobblesDataClassesDataContext())
                {
                    int count = (from t in dc.Members where t.Email == username && t.Password == password && t.Status == (byte)GeneralStatusType.Active select t).Count();
                    if (count == 1)
                    {
                        return true;
                    }
                    else
                    {
                        return false;
                    }
                }
            }
            catch
            {
                throw;
            }
        }

        public static MemberTypeType UserType(string username)
        {
            try
            {
                using (IndiaBobblesDataClassesDataContext dc = new IndiaBobblesDataClassesDataContext())
                {
                    Member m = (from t in dc.Members where t.Email == username select t).SingleOrDefault();
                    if (m != null)
                    {
                        return (MemberTypeType)(Enum.Parse(typeof(MemberTypeType), m.UserType.ToString()));
                    }
                    else
                    {
                        return MemberTypeType.Reader;
                    }
                }
            }
            catch(Exception ex)
            {
                HttpContext.Current.Trace.Write(ex.Message);
                HttpContext.Current.Trace.Write(ex.StackTrace);
                return MemberTypeType.Reader;
            }
        }

        public static bool Update(string username, 
            string name, bool newsletter,
            DateTime dob, string country, string alternateEmail,
            string mobile, string alternateEmail2,
            string phone, string address,
            string lastname, long modifiedby,
            string gender)
        {
            try
            {
                using (IndiaBobblesDataClassesDataContext dc = new IndiaBobblesDataClassesDataContext())
                {
                    var m = (from t in dc.Members where t.Email == username select t).SingleOrDefault();
                    m.MemberName = name;
                    m.Newsletter = newsletter;
                    m.DOB = dob;
                    m.Country = country;
                    m.AlternateEmail = alternateEmail;
                    m.AlternateEmail2 = alternateEmail2;
                    m.Mobile = mobile;
                    m.Phone = phone;
                    m.Address = address;
                    m.LastName = lastname;
                    m.ModifiedBy = modifiedby;
                    m.ModifyDate = DateTime.Now;
                    m.Gender = char.Parse(gender);
                    dc.SubmitChanges();
                    return true;
                }
            }
            catch 
            {
                throw;
            }
        }

        public static bool Update(string username, string name, bool newsletter, GeneralStatusType status)
        {
            try
            {
                using (IndiaBobblesDataClassesDataContext dc = new IndiaBobblesDataClassesDataContext())
                {
                    var m = (from t in dc.Members where t.Email == username select t).SingleOrDefault();
                    m.MemberName = name;
                    m.Newsletter = newsletter;
                    m.Status = (byte)status;
                    dc.SubmitChanges();
                    return true;
                }
            }
            catch
            {
                throw;
            }
        }

        public static Member UpdateLastLogon(string username)
        {
            try
            {
                using (IndiaBobblesDataClassesDataContext dc = new IndiaBobblesDataClassesDataContext())
                {
                    var m = (from t in dc.Members where t.Email == username select t).SingleOrDefault();
                    m.LastLogon = DateTime.Now;
                    dc.SubmitChanges();
                    return m;
                }
            }
            catch
            {
                throw;
            }
        }

        public static void Delete(int id)
        {
            try
            {
                using (IndiaBobblesDataClassesDataContext dc = new IndiaBobblesDataClassesDataContext())
                {
                    var m = (from t in dc.Members where t.ID == id select t).SingleOrDefault();
                    m.Status = (byte)GeneralStatusType.Deleted;
                    dc.SubmitChanges();
                    
                }
            }
            catch (Exception ex)
            {
                HttpContext.Current.Trace.Write("Unable to delete account");
                HttpContext.Current.Trace.Write(ex.Message);
                HttpContext.Current.Trace.Write(ex.StackTrace);
            }
        }

        public static bool Delete(string id, long modifiedBy)
        {
            try
            {
                using (IndiaBobblesDataClassesDataContext dc = new IndiaBobblesDataClassesDataContext())
                {
                    var m = (from t in dc.Members where t.Email == id select t).SingleOrDefault();
                    m.Status = (byte)GeneralStatusType.Deleted;
                    m.ModifiedBy = modifiedBy;
                    m.ModifyDate = DateTime.Now;
                    dc.SubmitChanges();
                    return true;
                }
            }
            catch
            {
                throw;
            }
        }

        public static Member GetUser(string username)
        {
            try
            {
                using (IndiaBobblesDataClassesDataContext dc = new IndiaBobblesDataClassesDataContext())
                {
                    return (from t in dc.Members where (t.Email == username || t.UserName == username) && t.Status != (byte)GeneralStatusType.Deleted select t).SingleOrDefault();
                }
            }
            catch
            {
                throw;
            }
        }

        public static Member GetUser(int id)
        {
            try
            {
                using (IndiaBobblesDataClassesDataContext dc = new IndiaBobblesDataClassesDataContext())
                {
                    return (from t in dc.Members where t.ID == id select t).SingleOrDefault();
                }
            }
            catch
            {
                throw;
            }
        }

        public static List<Member> GetMemberList()
        {
            try
            {
                using (IndiaBobblesDataClassesDataContext dc = new IndiaBobblesDataClassesDataContext())
                {
                    return (from u in dc.Members where u.Status != (byte)GeneralStatusType.Deleted orderby u.Createdate descending select u).ToList<Member>();
                }
            }
            catch
            {
                throw;
            }
        }

        public static bool ActivateUser(int id)
        {
            try
            {
                using (IndiaBobblesDataClassesDataContext dc = new IndiaBobblesDataClassesDataContext())
                {
                    Member m = (from u in dc.Members where u.ID == id select u).SingleOrDefault();
                    m.Status = (byte)GeneralStatusType.Active;
                    dc.SubmitChanges();
                    return true;
                }
            }
            catch
            {
                throw;
            }
        }

        public static bool ToggleSubscriptionUser(long id, bool value)
        {
            try
            {
                using (IndiaBobblesDataClassesDataContext dc = new IndiaBobblesDataClassesDataContext())
                {
                    Member m = (from u in dc.Members where u.ID == id select u).SingleOrDefault();
                    m.Newsletter = value;
                    dc.SubmitChanges();
                    return true;
                }
            }
            catch
            {
                throw;
            }
        }

        public static bool ChangePassword(long id, string password)
        {
            using (IndiaBobblesDataClassesDataContext dc = new IndiaBobblesDataClassesDataContext())
            {
                Member m = (from u in dc.Members where u.ID == id select u).SingleOrDefault();
                m.Password = password;
                dc.SubmitChanges();
                return true;
            }
        }

        public static bool CreateUser(string username, string password, bool newsletter, string memberName, DateTime? dob,
            string gender)
        {
            try
            {
                if (username.Trim() == string.Empty)
                {
                    return false;
                }
                if (password.Trim() == string.Empty)
                {
                    return false;
                }
                if (EmailExist(username))
                {
                    return false;
                }

                using (IndiaBobblesDataClassesDataContext dc = new IndiaBobblesDataClassesDataContext())
                {
                    Member m = new Member();
                    m.Createdate = DateTime.Now;
                    m.Email = username;
                    m.MemberName = memberName;
                    m.Newsletter = newsletter;
                    m.Password = password;
                    m.Status = (byte)GeneralStatusType.Active;
                    m.UserType = (byte)MemberTypeType.Member;
                    m.DOB = dob;
                    if (gender != string.Empty)
                    {
                        m.Gender = char.Parse(gender);
                    }
                    else { m.Gender = '\0'; }
                    dc.Members.InsertOnSubmit(m);
                    dc.SubmitChanges();
                    return true;
                }
            }
            catch
            {
                throw;
            }
        }

        public static bool EmailExist(string email)
        {
            try
            {
                using (IndiaBobblesDataClassesDataContext dc = new IndiaBobblesDataClassesDataContext())
                {
                    int count = (from t in dc.Members where t.Email == email select t).Count();
                    if (count > 0)
                    {
                        return true;
                    }
                    else
                    {
                        return false;
                    }
                }
            }
            catch
            {
                throw;
            }
        }

        public static bool UserNameExist(string username)
        {
            try
            {
                using (IndiaBobblesDataClassesDataContext dc = new IndiaBobblesDataClassesDataContext())
                {
                    int count = (from t in dc.Members where t.UserName == username select t).Count();
                    if (count > 0)
                    {
                        return true;
                    }
                    else
                    {
                        return false;
                    }
                }
            }
            catch
            {
                throw;
            }
        }
    }
}