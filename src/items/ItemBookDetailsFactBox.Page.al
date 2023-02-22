page 50355 "Item Book Details FactBox"
{
    ApplicationArea = All;
    Caption = 'Book Details';
    PageType = CardPart;
    SourceTable = Item;

    layout
    {
        area(content)
        {
            field(Author; Rec.Author)
            {
                ToolTip = 'Specifies the value of the Author field.';
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

    var
        BookPreview: Text;

    trigger OnAfterGetRecord()
    begin
        BookPreview := Rec.GetPreview();
    end;
}
