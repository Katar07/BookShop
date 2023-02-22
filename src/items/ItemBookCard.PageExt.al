pageextension 50350 "Item Book Card" extends "Item Card"
{
    layout
    {
        modify(ItemAttributesFactbox)
        {
            Visible = false;
        }

        addafter("Item")
        {
            group("Books Details")
            {
                field("Book Series No."; Rec."Book Series No.")
                {
                    ToolTip = 'Specifies the value of the Book Series No. field.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Book Category Name"; Rec."Book Category Name")
                {
                    ToolTip = 'Specifies the value of the Book Category Name field.';
                    ApplicationArea = All;
                }
                field("Author Name"; Rec.Author)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Author field.';
                }
                field("Book Series Name"; Rec."Book Series Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Book Series Name field.';
                }

                group("Book Preview")
                {
                    Caption = 'Book preview';

                    field(BookPreview; BookPreview)
                    {
                        ApplicationArea = Basic, Suite;
                        Importance = Additional;
                        MultiLine = true;
                        ShowCaption = false;
                        ToolTip = 'Specifies preview of the book';

                        trigger OnValidate()
                        var
                        begin
                            Rec.SetPreview(BookPreview);
                        end;
                    }
                }
            }
        }
        addafter(ItemPicture)
        {

            part(BookSeries; "Book In Series Factbox")
            {
                ApplicationArea = All;
                SubPageLink = "Book Series Name" = field("Book Series Name"),
                "Book Series No." = filter('>1');
            }
        }
    }

    actions
    {
        addafter("Item Journal")
        {
            action("Copy to Backend")
            {
                ApplicationArea = All;
                Image = Add;

                ToolTip = 'Executes the Go to Back action.';
                trigger OnAction()
                var
                    ItemWebService: Codeunit "WS Item";
                begin
                    ItemWebService.Run(Rec);
                end;
            }
        }
    }

    var
        BookPreview: Text;

    trigger OnAfterGetRecord()
    begin
        BookPreview := Rec.GetPreview();
    end;

}


