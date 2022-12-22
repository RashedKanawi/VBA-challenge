Attribute VB_Name = "Module1"
Sub MultipleYearStockData():

    For Each ws In Worksheets
    
        Dim WorksheetName As String
        Dim TickCount As Long
        Dim LastRowA As Long
        Dim LastRowI As Long
        Dim PerChange As Double

        WorksheetName = ws.Name
        ws.Cells(1, 9).Value = "Ticker"
        ws.Cells(1, 10).Value = "Yearly Change"
        ws.Cells(1, 11).Value = "Percent Change"
        ws.Cells(1, 12).Value = "Total Stock Volume"
        ws.Cells(2, 15).Value = "Greatest % Increase"
        ws.Cells(3, 15).Value = "Greatest % Decrease"
        ws.Cells(4, 15).Value = "Greatest Total Volume"
        ws.Cells(1, 16).Value = "Ticker"
        ws.Cells(1, 17).Value = "Value"
        
        'first row
        TickCount = 2
        
        Dim i As Long
        Dim j As Long
        j = 2
        
        LastRowA = ws.Cells(Rows.Count, 1).End(xlUp).Row
        
            For i = 2 To LastRowA
            
                'if the name changed
                If ws.Cells(i + 1, 1).Value <> ws.Cells(i, 1).Value Then
                
                'ticker in column (I)
                ws.Cells(TickCount, 9).Value = ws.Cells(i, 1).Value
                
                'Yearly Change in column (J)
                ws.Cells(TickCount, 10).Value = ws.Cells(i, 6).Value - ws.Cells(j, 3).Value
                
    
                    If ws.Cells(TickCount, 10).Value > 0 Then
                
                    'change color to green
                    ws.Cells(TickCount, 10).Interior.ColorIndex = 4

                    Else
                                        
                    'change color to red
                    ws.Cells(TickCount, 10).Interior.ColorIndex = 3
                
                    End If
                    
                    'percent change in column (K)
                    If ws.Cells(j, 3).Value <> 0 Then
                    PerChange = ((ws.Cells(i, 6).Value - ws.Cells(j, 3).Value) / ws.Cells(j, 3).Value)
                    
                    'Percent formating
                    ws.Cells(TickCount, 11).Value = Format(PerChange, "Percent")
                    
                    Else
                    
                    ws.Cells(TickCount, 11).Value = Format(0, "Percent")
                    
                    End If
                    
                'total volume in column (L)
                ws.Cells(TickCount, 12).Value = WorksheetFunction.Sum(Range(ws.Cells(j, 7), ws.Cells(i, 7)))
                
                TickCount = TickCount + 1
                
                j = i + 1
                
                End If
            
            Next i
            
        'Last row in I
        LastRowI = ws.Cells(Rows.Count, 9).End(xlUp).Row
        

        Dim GreatVol As Double
        Dim GreatDecr As Double
        Dim GreatIncr As Double
        
        GreatVol = ws.Cells(2, 12).Value
        GreatIncr = ws.Cells(2, 11).Value
        GreatDecr = ws.Cells(2, 11).Value
        
            For i = 2 To LastRowI
            
                'greatest total volume
                If ws.Cells(i, 12).Value > GreatVol Then
                GreatVol = ws.Cells(i, 12).Value
                ws.Cells(4, 16).Value = ws.Cells(i, 9).Value
                
                Else
                
                GreatVol = GreatVol
                
                End If
                
                'greatest increase
                If ws.Cells(i, 11).Value > GreatIncr Then
                GreatIncr = ws.Cells(i, 11).Value
                ws.Cells(2, 16).Value = ws.Cells(i, 9).Value
                
                Else
                
                GreatIncr = GreatIncr
                
                End If
                
                'greatest decrease
                If ws.Cells(i, 11).Value < GreatDecr Then
                GreatDecr = ws.Cells(i, 11).Value
                ws.Cells(3, 16).Value = ws.Cells(i, 9).Value
                
                Else
                
                GreatDecr = GreatDecr
                
                End If
                
            ws.Cells(2, 17).Value = Format(GreatIncr, "Percent")
            ws.Cells(3, 17).Value = Format(GreatDecr, "Percent")
            ws.Cells(4, 17).Value = Format(GreatVol, "Scientific")
            
            Next i
            
    Next ws
        
End Sub
