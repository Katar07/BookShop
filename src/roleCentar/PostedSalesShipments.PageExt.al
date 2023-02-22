pageextension 50355 "Posted Sales Shipments" extends "Posted Sales Shipments"
{

    trigger OnOpenPage()
    var
        UserLoginManagement: Codeunit "User Login Management";
    begin
        Rec.SetRange("Sell-to Customer No.", UserLoginManagement.GetCurrentUserLogin()."Customer No.");
        Rec.SetCurrentKey("No.");
        Rec.SetAscending("No.", true);
    end;
}
