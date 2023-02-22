pageextension 50356 "Posted Sales Credit Memos Ext." extends "Posted Sales Credit Memos"
{

    trigger OnOpenPage()
    var
        UserLoginManagement: Codeunit "User Login Management";
    begin
        Rec.SetRange("Bill-to Customer No.", UserLoginManagement.GetCurrentUserLogin()."Customer No.");
        Rec.SetCurrentKey("No.");
        Rec.SetAscending("No.", true);
    end;
}
