classdef phase5 < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                       matlab.ui.Figure
        Lamp                           matlab.ui.control.Lamp
        y2forscatterEditField          matlab.ui.control.NumericEditField
        y2forscatterEditFieldLabel     matlab.ui.control.Label
        y1forscatterEditField          matlab.ui.control.NumericEditField
        y1forscatterLabel              matlab.ui.control.Label
        y2EditField                    matlab.ui.control.NumericEditField
        y2EditFieldLabel               matlab.ui.control.Label
        PlotButton                     matlab.ui.control.Button
        selectanyoneplotDropDown       matlab.ui.control.DropDown
        selectanyoneplotDropDownLabel  matlab.ui.control.Label
        uploaddataxlsxButton           matlab.ui.control.Button
        y1EditField                    matlab.ui.control.NumericEditField
        y1EditFieldLabel               matlab.ui.control.Label
        colforxAxisEditField           matlab.ui.control.NumericEditField
        colforxAxisEditFieldLabel      matlab.ui.control.Label
        UIAxes                         matlab.ui.control.UIAxes
    end

        properties (Access = private)
        data % Description
        check % to handle scatter
    end
    
    

    % Callbacks that handle component events
    methods (Access = private)

        % Button pushed function: uploaddataxlsxButton
        function uploaddataxlsxButtonPushed(app, event)
            [file, path] = uigetfile('*.xlsx', 'Select Excel File');
            
            if file ~= 0
                % Read the Excel file and store the data in the app's property
                % app.ExcelData = readtable(fullfile(path, file));
                app.data = xlsread(fullfile(path, file));
                %update lamp to ensure that your data is uploded
                app.Lamp.Color='g';
                % now read two column
              % x=app.colforxAxisEditField.Value;
              % y=app.y1EditField.Value;
          % column1 = app.data(:, x); % Extract the first column (assuming it exists)
          % column3 = app.data(:, y);
                 % app.UITable.Data=readtable(fullfile(path, file));
                % Display the file name
                % app.FileLabel.Text = ['File: ', file];
                % 
                % % Update the table data
                % app.DataTable.Data = app.ExcelData;
            end

        end

        % Button pushed function: PlotButton
        function PlotButtonPushed(app, event)
              cla(app.UIAxes);
              
              x=app.colforxAxisEditField.Value;
              vy1=app.y1EditField.Value;
               
              vy2=app.y2EditField.Value;
            


          %var p to check which plot
          hold(app.UIAxes, 'on');
          p=app.selectanyoneplotDropDown.Value;
          if strcmp(app.check, 'Scatter')
            vy1=0;
            vy2=0;
            cla(app.UIAxes);
            c1=app.y1forscatterEditField.Value;
            c2=app.y2forscatterEditField.Value;
            x1=app.data(:, c1);
            y1=app.data(:, c2);
              scatter(app.UIAxes, x1, y1, 'red', 'filled' ,'DisplayName','y1');
             st=min(x1);
             st=max(st-10, 0);
             var1=max(y1);
             var2=max(x1);
             last=max(var2, var1);
             last=last+20;
             line_range = [st, last];
      plot(app.UIAxes, line_range, line_range, 'b--', 'LineWidth', 2, 'DisplayName','45 deg');
    

          else
            x1 = app.data(:, x); % Extract the first column (assuming it exists)
          end   
          
           if vy1>0
          y1 = app.data(:, vy1);  % extract data for y1 column vector to plot 
           if strcmp(p,'Line')
            plot(app.UIAxes, x1, y1, 'b-', 'LineWidth', 2, 'DisplayName','Y1');

               %         elseif strcmp(p, 'Scatter')
               % scatter(app.UIAxes, x1, y1, 'b', 'filled' , 'DisplayName','Y1');
                          else
               bar(app.UIAxes, x1, y1, 'b', 'DisplayName','Y1');
           end  
           end
       
           if vy2>0
              y2=app.data(:, vy2); % extract data for y2
             if strcmp(p,'Line')
            plot(app.UIAxes, x1, y2, 'r--', 'LineWidth', 2 ,'DisplayName','Y2');
             % legend('Y2');
           % elseif strcmp(p, 'Scatter')
           %     scatter(app.UIAxes, x1, y2, 'red', 'filled' ,'DisplayName','Y2');
           else
               bar(app.UIAxes, x1, y2, 'red','DisplayName','Y2');
             end 
           end

           hold(app.UIAxes, 'off');
           if (vy1>0 || vy2>0) 
           app.y1forscatterEditField.Visible="off";
           app.y2forscatterEditField.Visible="off";
           end
           legend(app.UIAxes, 'Location', 'best');
          

        end

        % Value changed function: selectanyoneplotDropDown
        function selectanyoneplotDropDownValueChanged(app, event)
            value = app.selectanyoneplotDropDown.Value;
            app.check="Scatter";
            if strcmp(value, app.check) 
            app.y1forscatterEditField.Visible="on";
            app.y2forscatterEditField.Visible="on";
            else
              app.check="-1";
            end


        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Position = [100 100 742 626];
            app.UIFigure.Name = 'MATLAB App';

            % Create UIAxes
            app.UIAxes = uiaxes(app.UIFigure);
            xlabel(app.UIAxes, 'X')
            ylabel(app.UIAxes, 'Y')
            zlabel(app.UIAxes, 'Z')
            app.UIAxes.Box = 'on';
            app.UIAxes.YGrid = 'on';
            app.UIAxes.Position = [163 62 440 316];

            % Create colforxAxisEditFieldLabel
            app.colforxAxisEditFieldLabel = uilabel(app.UIFigure);
            app.colforxAxisEditFieldLabel.HorizontalAlignment = 'right';
            app.colforxAxisEditFieldLabel.Position = [24 514 72 22];
            app.colforxAxisEditFieldLabel.Text = 'col for x Axis';

            % Create colforxAxisEditField
            app.colforxAxisEditField = uieditfield(app.UIFigure, 'numeric');
            app.colforxAxisEditField.Position = [111 514 100 22];

            % Create y1EditFieldLabel
            app.y1EditFieldLabel = uilabel(app.UIFigure);
            app.y1EditFieldLabel.HorizontalAlignment = 'right';
            app.y1EditFieldLabel.Position = [71 480 25 22];
            app.y1EditFieldLabel.Text = 'y1';

            % Create y1EditField
            app.y1EditField = uieditfield(app.UIFigure, 'numeric');
            app.y1EditField.Position = [111 480 100 22];

            % Create uploaddataxlsxButton
            app.uploaddataxlsxButton = uibutton(app.UIFigure, 'push');
            app.uploaddataxlsxButton.ButtonPushedFcn = createCallbackFcn(app, @uploaddataxlsxButtonPushed, true);
            app.uploaddataxlsxButton.Position = [54 557 110 23];
            app.uploaddataxlsxButton.Text = 'upload data (xlsx)';

            % Create selectanyoneplotDropDownLabel
            app.selectanyoneplotDropDownLabel = uilabel(app.UIFigure);
            app.selectanyoneplotDropDownLabel.HorizontalAlignment = 'right';
            app.selectanyoneplotDropDownLabel.Position = [8 416 105 22];
            app.selectanyoneplotDropDownLabel.Text = 'select any one plot';

            % Create selectanyoneplotDropDown
            app.selectanyoneplotDropDown = uidropdown(app.UIFigure);
            app.selectanyoneplotDropDown.Items = {'Line', 'Scatter', 'Bar'};
            app.selectanyoneplotDropDown.ValueChangedFcn = createCallbackFcn(app, @selectanyoneplotDropDownValueChanged, true);
            app.selectanyoneplotDropDown.Position = [128 416 100 22];
            app.selectanyoneplotDropDown.Value = 'Line';

            % Create PlotButton
            app.PlotButton = uibutton(app.UIFigure, 'push');
            app.PlotButton.ButtonPushedFcn = createCallbackFcn(app, @PlotButtonPushed, true);
            app.PlotButton.Position = [54 355 100 23];
            app.PlotButton.Text = 'Plot';

            % Create y2EditFieldLabel
            app.y2EditFieldLabel = uilabel(app.UIFigure);
            app.y2EditFieldLabel.HorizontalAlignment = 'right';
            app.y2EditFieldLabel.Position = [71 449 25 22];
            app.y2EditFieldLabel.Text = 'y2';

            % Create y2EditField
            app.y2EditField = uieditfield(app.UIFigure, 'numeric');
            app.y2EditField.Position = [111 449 100 22];

            % Create y1forscatterLabel
            app.y1forscatterLabel = uilabel(app.UIFigure);
            app.y1forscatterLabel.HorizontalAlignment = 'right';
            app.y1forscatterLabel.Position = [279 416 74 22];
            app.y1forscatterLabel.Text = 'y1 for scatter';

            % Create y1forscatterEditField
            app.y1forscatterEditField = uieditfield(app.UIFigure, 'numeric');
            app.y1forscatterEditField.Visible = 'off';
            app.y1forscatterEditField.Position = [368 416 100 22];

            % Create y2forscatterEditFieldLabel
            app.y2forscatterEditFieldLabel = uilabel(app.UIFigure);
            app.y2forscatterEditFieldLabel.HorizontalAlignment = 'right';
            app.y2forscatterEditFieldLabel.Position = [494 416 74 22];
            app.y2forscatterEditFieldLabel.Text = 'y2 for scatter';

            % Create y2forscatterEditField
            app.y2forscatterEditField = uieditfield(app.UIFigure, 'numeric');
            app.y2forscatterEditField.Visible = 'off';
            app.y2forscatterEditField.Position = [583 416 100 22];

            % Create Lamp
            app.Lamp = uilamp(app.UIFigure);
            app.Lamp.Position = [191 558 20 20];
            app.Lamp.Color = [1 1 1];

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = phase5

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end