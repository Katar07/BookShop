page 50375 "Rent Cart List"
{
    ApplicationArea = All;
    Caption = 'Rent Cart List';
    PageType = List;
    Editable = false;
    SourceTable = "Rent Cart";
    UsageCategory = Lists;
    CardPageId = "Rent Card";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
            }
        }
    }
    trigger OnOpenPage()
    var
        UserLoginManagement: Codeunit "User Login Management";
    begin
        Rec.SetRange("Customer No", UserLoginManagement.GetCurrentUserLogin()."Customer No.");
    end;
}
