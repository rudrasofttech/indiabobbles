namespace IndiaBobbles.Models
{
    public enum PostStatusType
    {
        Draft = 1,
        Publish = 2,
        Inactive = 3
    }

    public enum PageCommentType
    {
        General = 1
    }

    public enum GeneralStatusType
    {
        Active = 0,
        Inactive = 1,
        Deleted = 2
    }

    public enum MemberTypeType
    {
        Admin = 1,
        Author = 2,
        Member = 3,
        Reader = 4,
        Editor = 5
    }
}

namespace IndiaBobbles
{
    public enum AlertType
    {
        Success,
        Warning,
        Error,
        Info
    }
}