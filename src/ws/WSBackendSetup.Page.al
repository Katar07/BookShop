page 50359 "WS Backend Setup"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "WS Backend Setup";
    Caption = 'Backend Setup';

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field(BaseURL; Rec."Web Service Base URL")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Web Service Base URL field.';
                }

                field(CompanyId; Rec."Company Id")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Company Id field.';
                }
            }
            group(Authorization)
            {
                Caption = 'Authorization';

                field(UserName; Rec."User Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the User Name field.';
                }
                field(Password; Rec.Password)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the User Password field.';
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        if not Rec.Get() then
            Rec.Insert(true);
    end;
}