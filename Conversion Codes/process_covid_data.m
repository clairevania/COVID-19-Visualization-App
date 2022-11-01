function covid_data = process_covid_data()
    covid_data = {'Country' 'State'};
    raw_cases = readcell('time_series_covid19_confirmed_global.csv');
    for ii = 5:size(raw_cases,2)
        raw_cases{1,ii} = sprintf('%d/%d/%d',   raw_cases{1,ii}.Month,...
                                                raw_cases{1,ii}.Day,...
                                                raw_cases{1,ii}.Year);
    end
    covid_data = [covid_data raw_cases(1,5:end)];
    
    raw_deaths = readtable('time_series_covid19_deaths_global.csv');
    raw_deaths = table2cell(raw_deaths);
    
    cases = raw_cases(2:end,5:end);
    deaths = raw_deaths(2:end,5:end);
    countries = raw_cases(2:end,2);
    states = raw_cases(2:end,1);
    for ii = 1:size(cases,1)
        if ~isempty(strfind(countries{ii},'Princess'))
            continue;
        end
        covid_data{end+1,1} = countries{ii};
        if strcmp(countries{ii},'US')
            covid_data{end,1} = 'United States';
        end
        covid_data{end,2} = states{ii};
        for jj = 1:size(cases,2)
            covid_data{end,jj+2} = [(cases{ii,jj}) (deaths{ii,jj}) ];
        end
    end
    
    raw_cases = readtable('time_series_covid19_confirmed_US.csv');
    raw_cases = table2cell(raw_cases);
    raw_deaths = readtable('time_series_covid19_deaths_US.csv');
    raw_deaths = table2cell(raw_deaths);
    cur_state = '';
    for ii = 2:size(raw_deaths,1)
        state = raw_deaths{ii,7};
        if ~isempty(strfind(state,'Princess'))
            continue;
        end
        if ~strcmp(cur_state,state)
                if ~isempty(cur_state)
                    covid_data{end+1,1} = 'United States';
                    covid_data{end,2} = cur_state;
                    for jj = 1:size(raw_cases,2)-11
                        covid_data{end,jj+2} = [case_count(jj) death_count(jj)];
                    end
                end
                death_count = zeros(1,size(raw_cases,2)-11);
                case_count = zeros(1,size(raw_cases,2)-11);
                cur_state = state;
        end
        for jj = 1:size(raw_cases,2)-11
            death_count(jj) = death_count(jj) + (raw_deaths{ii,jj+12});
            case_count(jj) = case_count(jj) + (raw_cases{ii,jj+11});
        end 
    end
    covid_data{end+1,1} = 'United States';  % Add the last one, Wyoming
    covid_data{end,2} = cur_state;
    for jj = 1:size(raw_cases,2)-11
        covid_data{end,jj+2} = [case_count(jj) death_count(jj)];
    end
    
    special = {'Australia' , 'Canada' , 'China' };
    for name = special
        indexes = [];
        for ii = 2:size(covid_data,1)
            if strcmp(covid_data{ii,1},name{1})
                indexes(end+1) = ii;
            end
        end
        covid_data{end+1,1} = name{1};
        covid_data{end,2} = '';
        for jj = 3:size(covid_data,2)
            covid_data{end,jj} = [0 0];
            for ii = indexes
                covid_data{end,jj} = covid_data{end,jj} + covid_data{ii,jj};
            end
        end 
    end        
    for ii = 2:size(covid_data,1)
        if ismissing(covid_data{ii,2})
            covid_data{ii,2} = '';
        end
    end
    covid_data{1,1} = 'AAA';
    covid_data = sortrows(covid_data,[1 2]);
    covid_data{1,1} = 'Country';
end