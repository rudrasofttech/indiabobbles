using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using IndiaBobbles;
using IndiaBobbles.Models;

public partial class Admin_ManageMember : AdminPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (ForbidUserAccess(MemberTypeType.Admin))
        {
            Response.Redirect("default.aspx");
        }

        if (!Page.IsPostBack && !Page.IsCallback)
        {
            PopulateYear();
            PopulateDays();
            if (Mode == "edit")
            {
                Bind();
            }
            else
            {
                Response.Redirect("memberlist.aspx");
            }
            
        }
    }
    public void PopulateYear()
    {
        YearDropDown.Items.Clear();
        int year = DateTime.Now.Year - 13;
        for (int i = year; i >= (year - 80); i--)
        {
            YearDropDown.Items.Add(new ListItem(i.ToString(), i.ToString()));
        }
    }

    public void PopulateDays()
    {
        DateDropDown.Items.Clear();
        for (int i = 1; i <= DateTime.DaysInMonth(int.Parse(YearDropDown.SelectedValue), int.Parse(MonthDropDown.SelectedValue)); i++)
        {
            DateDropDown.Items.Add(new ListItem(i.ToString(), i.ToString()));
        }
    }
    private void Bind()
    {
        try
        {
            Member m = MemberManager.GetUser(ID);
            EmailTextBox.Text = m.Email;
            PasswordTextBox.Text = m.Password;
            NameTextBox.Text = m.MemberName;
            StatusDropDown.SelectedValue = m.Status.ToString();
            MemberTypeDropDown.SelectedValue = m.UserType.ToString();
            NewsletterCheckBox.Checked = m.Newsletter;
            LastNameTextBox.Text = m.LastName;
            if (m.DOB.HasValue)
            {
                YearDropDown.SelectedValue = m.DOB.Value.Year.ToString();
                MonthDropDown.SelectedValue = m.DOB.Value.Month.ToString();
                PopulateDays();
                DateDropDown.SelectedValue = m.DOB.Value.Date.ToString();
            }
            CountryDropDown.SelectedValue = m.Country;

            AltEmailTextBox.Text = m.AlternateEmail;
            AltEmail2TextBox.Text = m.AlternateEmail2;
            MobileTextBox.Text = m.Mobile;
            PhoneTextBox.Text = m.Phone;
            AddressTextBox.Text = m.Address;
            if (m.Gender.HasValue)
            {
                GenderDropDown.SelectedValue = m.Gender.Value.ToString();
            }
        }
        catch (Exception ex)
        {
            Response.Redirect("memberlist.aspx");
            Trace.Write("Unable to load member details.");
            Trace.Write(ex.Message);
            Trace.Write(ex.StackTrace);
        }
    }
    protected void SubmitButton_Click(object sender, EventArgs e)
    {
        Page.Validate("MemberGrp");
        if (!Page.IsValid) return;
        try
        {
            DateTime dob = DateTime.Parse(string.Format("{0}-{1}-{2}", YearDropDown.SelectedValue, MonthDropDown.SelectedValue,
                DateDropDown.SelectedValue));
            using (IndiaBobblesDataClassesDataContext db = new IndiaBobblesDataClassesDataContext())
            {
                Member m = (from u in db.Members where u.ID == ID select u).SingleOrDefault();
                m.MemberName = NameTextBox.Text.Trim();
                m.Password = PasswordTextBox.Text.Trim();
                m.Status = byte.Parse(StatusDropDown.SelectedValue);
                m.UserType = byte.Parse(MemberTypeDropDown.SelectedValue);
                m.Newsletter = NewsletterCheckBox.Checked;
                m.DOB = dob;
                m.Country = CountryDropDown.SelectedValue;
                m.AlternateEmail = AltEmailTextBox.Text.Trim();
                m.AlternateEmail2 = AltEmail2TextBox.Text.Trim();
                m.Mobile = MobileTextBox.Text.Trim();
                m.Phone = PhoneTextBox.Text.Trim();
                m.Address = AddressTextBox.Text.Trim();
                m.LastName = LastNameTextBox.Text.Trim();
                m.ModifiedBy = CurrentUser.ID;
                m.ModifyDate = DateTime.Now;
                m.Gender = char.Parse(GenderDropDown.SelectedValue);
                db.SubmitChanges();
                Response.Redirect("memberlist.aspx");
            }
        }
        catch (Exception ex)
        {
            
            Trace.Write("Unable to load member details.");
            Trace.Write(ex.Message);
            Trace.Write(ex.StackTrace);
        }
    }

    protected void YearDropDown_SelectedIndexChanged(object sender, EventArgs e)
    {
        PopulateDays();
    }
    protected void MonthDropDown_SelectedIndexChanged(object sender, EventArgs e)
    {
        PopulateDays();
    }
}