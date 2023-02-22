pageextension 50352 "Posted Sales Invoices Ext." extends "Posted Sales Invoices"
{
    actions
    {
        addafter(Navigate)
        {
            action(RentOrder)
            {
                Caption = 'My Rent Orders';
                ApplicationArea = All;
                ToolTip = 'Executes the Rent Order action.';
                Image = Navigate;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                begin
                    page.Run(Page::"Posted Sales Shipments");
                end;
            }
            action(BackendPosted)
            {
                Caption = 'Backend Posted Invoices';
                ApplicationArea = All;
                ToolTip = 'Executes the Backend Posted Invoices action.';
                Image = Navigate;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                begin
                    OpenBackendPostedSalesInvoices();
                end;
            }
        }
    }

    trigger OnOpenPage()
    var
        UserLoginManagement: Codeunit "User Login Management";
    begin
        Rec.SetRange("Bill-to Customer No.", UserLoginManagement.GetCurrentUserLogin()."Customer No.");
        Rec.SetCurrentKey("No.");
        Rec.SetAscending("No.", true);
    end;

    procedure OpenBackendPostedSalesInvoices()
    var
        UserLoginManagement: Codeunit "User Login Management";
    begin
        Hyperlink(CreateLink('https://bc-webshop.westeurope.cloudapp.azure.com/BC/'
        + '?company=CRONUS%20International%20Ltd.'
        + '&page=143'
        + '&filter="Sell-to Customer No." IS "'
        + UserLoginManagement.GetCurrentUserLogin()."Backend Customer No."
        + '"'));
    end;

    procedure CreateLink(url: Text): Text

    begin
        exit(url.Replace('"', ''''));
    end;
}
