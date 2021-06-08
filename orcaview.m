% Matlab UI to look at g, hyperfine and quadrupole tensors caluclated by ORCA.

% Version 0.9
% Stefan Stoll, University of Washington

function orcaview

% Initialize figure
figureID = 2147482535;
if ishandle(figureID), close(figureID); end
f = figure(figureID);
set(f,...
  'Name','OrcaView',...
  'NumberTitle','off',...
  'Menubar','none',...
  'Color','w',...
  'WindowStyle','normal');

ss = get(0,'ScreenSize');
Width = 800; Height = 600;
p = [ss(3)/2-Width/2 ss(4)/2-Height/2 Width Height];
set(f,'Position',p);

p = get(f,'Position');
Height = p(4);
clf(f)

set(f,'ResizeFcn',@resizefunction);
set(f,'HandleVisibility','off');

x = 5;
y = Height-20;
hLoadButton = uicontrol(...
  'Parent',f,...
  'Style','PushButton',...
  'Position',[x y 50 20],...
  'String','Open...');
set(hLoadButton,'Callback',{@loadButton_callback});
hCloseButton = uicontrol(...
  'Parent',f,...
  'Style','PushButton',...
  'Position',[x+50 y 60 20],...
  'String','Close');
set(hCloseButton,'Callback',{@closeButton_callback});
hCloseAllButton = uicontrol(...
  'Parent',f,...
  'Style','PushButton',...
  'Position',[x+120 y 70 20],...
  'String','Close all');
set(hCloseAllButton,'Callback',{@closeallButton_callback});

hSettingsButton = uicontrol(...
  'Parent',f,...
  'Style','ToggleButton',...
  'Position',[0 0 70 20],...
  'String','Settings',...
  'Value',1);
set(hSettingsButton,'Callback',{@settingsButton_callback});

hFileList = uicontrol(...
  'Parent',f,...
  'Style','ListBox',...
  'Position',[x y-70 200 70],...
  'Backgroundcolor',[1 1 0.8],...
  'Callback',{@fileList_callback});

data = [];

sHeight = 140; sWidth = 160;
y = sHeight - [1 2 3 4 5 6 7]*20-5;
x = 5;
hSettingsPanel = uipanel(...
  'Parent',f,...
  'Title','',...
  'Unit','Pixels',...
  'Position',[2 20 sWidth sHeight]);

hSpinPopulationsCheckBox = uicontrol(...
  'Parent',hSettingsPanel,...
  'Style','CheckBox',...
  'Position',[x y(1) 150 20],...
  'String','Mulliken spin populations',...
  'Value',1,...
  'Callback',@updatedisplay_callback);

hgCheckBox = uicontrol(...
  'Parent',hSettingsPanel,...
  'Style','CheckBox',...
  'Position',[x y(2) 150 20],...
  'String','g values and frame',...
  'Value',1,...
  'Callback',@updatedisplay_callback);

hHyperfineCheckBox = uicontrol(...
  'Parent',hSettingsPanel,...
  'Style','CheckBox',...
  'Position',[x y(3) 150 20],...
  'String','Hyperfine values (MHz)',...
  'Value',1,...
  'Callback',@updatedisplay_callback);

hFramesCheckBox = uicontrol(...
  'Parent',hSettingsPanel,...
  'Style','CheckBox',...
  'Position',[x y(4) 150 20],...
  'String','Hyperfine ellipsoids',...
  'Value',1,...
  'Callback',@updatedisplay_callback);

hQuadrupoleCheckBox = uicontrol(...
  'Parent',hSettingsPanel,...
  'Style','CheckBox',...
  'Position',[x y(5) 150 20],...
  'String','Quadrupole values',...
  'Value',0,...
  'Callback',@updatedisplay_callback);

hAtomLabelsCheckBox = uicontrol(...
  'Parent',hSettingsPanel,...
  'Style','CheckBox',...
  'Position',[x y(6) 150 20],...
  'String','Atom labels',...
  'Value',0,...
  'Callback',@updatedisplay_callback);

hDisplay = axes(...
  'Parent',f,...
  'XTick',[],'YTick',[],...
  'Units','normalized',...
  'Position',[0 0 1 1],...
  'Visible','off',...
  'HandleVisibility','on');
%colormap(hDisplay,'jet');

drawnow;


loadButton_callback();

  function displayMolecule(idx)
    axes(hDisplay);
    set(hDisplay,'HandleVisibility','on');
    cla(hDisplay);
    set(hDisplay,'Visible','off');
    if nargin==0, idx = get(hFileList,'Value'); end
    if isempty(idx) || idx==0, return; end
    if idx>numel(data), return; end
    set(hDisplay,'Visible','on');
    
    oldidx = get(hFileList,'Value');
    [az,el]=view(hDisplay);
    data(oldidx).azel = [az,el];
    thisdata= data(idx);
    xyz = thisdata.xyz;
    h = plot3(xyz(:,1),xyz(:,2),xyz(:,3),'.k','Parent',hDisplay);
    if get(hAtomLabelsCheckBox,'Value')
      set(h,'Visible','off');
    end
    for k1=1:thisdata.nAtoms
      v1 = xyz(k1,:);
      if get(hAtomLabelsCheckBox,'Value')
        h = text(v1(1),v1(2),v1(3),sprintf('%d%s',k1-1,thisdata.Element{k1}),'Parent',hDisplay);
        set(h,'FontSize',8,'Horiz','c','Vert','m','Color',[1 0 0],...
          'BackgroundColor','none');
      end
      for k2=k1+1:thisdata.nAtoms
        v2 = xyz(k2,:);
        r =  norm(v2-v1);
        if thisdata.NucId(k1)==1 || thisdata.NucId(k2)==1
          bonding = r < 1.2;
        else
          bonding = r<1.9;
        end
        if bonding
          shrink = 0.2;
          bondstart = v1 + (v2-v1)*shrink;
          bondend = v2 - (v2-v1)*shrink;
          line([bondstart(1) bondend(1)],[bondstart(2) bondend(2)],...
            [bondstart(3) bondend(3)],'Color','k','Parent',hDisplay);
        end
        if (thisdata.NucId(k1)==1 || thisdata.NucId(k2)==1) && ...
            (thisdata.NucId(k1)==8 || thisdata.NucId(k2)==8)
          hbonding = r<2.5;
        else
          hbonding = 0;
        end
        if hbonding && ~bonding
          %line([v1(1) v2(1)],[v1(2) v2(2)],[v1(3) v2(3)],...
          %  'Color',[1 1 1]*0.5,'LineStyle',':','Parent',hDisplay);
        end
      end
    end
    
    axis(hDisplay,'equal');
    set(hDisplay,'CameraViewAngleMode','manual');
    axis(hDisplay,'off');

    % Display g matrix frame
    %-------------------------------------------------------------
    gTensorFrame = ~isempty(thisdata.g) && get(hgCheckBox,'Value');
    if gTensorFrame
      arrowLength = 1;
      Origin = mean(thisdata.xyz).';
      [V,E] = eig(thisdata.g); E = diag(E);
      V = arrowLength*V;
      dir1 = V(:,1);
      dir2 = V(:,2);
      dir3 = V(:,3);
      q = -1;
      h(1)=line(Origin(1)+[q 1]*dir1(1),Origin(2)+[q 1]*dir1(2),Origin(3)+[q 1]*dir1(3),'Color','r','Parent',hDisplay);
      h(2)=line(Origin(1)+[q 1]*dir2(1),Origin(2)+[q 1]*dir2(2),Origin(3)+[q 1]*dir2(3),'Color','g','Parent',hDisplay);
      h(3)=line(Origin(1)+[q 1]*dir3(1),Origin(2)+[q 1]*dir3(2),Origin(3)+[q 1]*dir3(3),'Color','b','Parent',hDisplay);
      set(h,'LineWidth',2)
      format = ' %0.6f';
      h(1) = text(Origin(1)+dir1(1),Origin(2)+dir1(2),Origin(3)+dir1(3),sprintf(format,E(1)),'Color','r','Parent',hDisplay);
      h(2) = text(Origin(1)+dir2(1),Origin(2)+dir2(2),Origin(3)+dir2(3),sprintf(format,E(2)),'Color',[0 0.5 0],'Parent',hDisplay);
      h(3) = text(Origin(1)+dir3(1),Origin(2)+dir3(2),Origin(3)+dir3(3),sprintf(format,E(3)),'Color','b','Parent',hDisplay);
      h(4) = text(Origin(1)-dir1(1),Origin(2)-dir1(2),Origin(3)-dir1(3),sprintf(format,E(1)),'Color','r','Parent',hDisplay);
      h(5) = text(Origin(1)-dir2(1),Origin(2)-dir2(2),Origin(3)-dir2(3),sprintf(format,E(2)),'Color',[0 0.5 0],'Parent',hDisplay);
      h(6) = text(Origin(1)-dir3(1),Origin(2)-dir3(2),Origin(3)-dir3(3),sprintf(format,E(3)),'Color','b','Parent',hDisplay);
      set(h,'FontSize',8);
    end
    
    
    % Display nuclear data
    %-------------------------------------------------------------
    hyperfineDisplay = get(hHyperfineCheckBox,'Value')==1;
    spinpopDisplay = get(hSpinPopulationsCheckBox,'Value')==1;
    quadrupoleDisplay = get(hQuadrupoleCheckBox,'Value')==1;
    plotHFframe = get(hFramesCheckBox,'Value')==1;
    
    if isempty(thisdata.MullikenSpin)
      set(hSpinPopulationsCheckBox,'Enable','off')
    else
      set(hSpinPopulationsCheckBox,'Enable','on')
    end
    
    for iAtom=1:thisdata.nAtoms
      
      if ~isempty(thisdata.MullikenSpin)
        if (abs(thisdata.MullikenSpin(iAtom))<0.00001), continue; end
      end
      
      % Spin populations
      %---------------------------------------------------------------
      if spinpopDisplay && ~isempty(thisdata.MullikenSpin)
        str = sprintf('%+0.4f ',thisdata.MullikenSpin(iAtom));
        h = text(xyz(iAtom,1),xyz(iAtom,2),xyz(iAtom,3),str,'Parent',hDisplay);
        set(h,'Fontsize',8,'VerticalAl','bottom','HorizontalAl','right','Color',[0.8 0 0]);
      end
      
      % Hyperfine
      %---------------------------------------------------------------
      if hyperfineDisplay || plotHFframe
        A = thisdata.hfc{iAtom};
        if isempty(A), continue; end
        [V,E] = eig(A); A = diag(E);
        [~,idx] = sort(abs(A)); A = A(idx); V = V(:,idx);
        maxA = max(abs(A));
        aboveThreshold = maxA > 1;
        if hyperfineDisplay && aboveThreshold && ~plotHFframe
          str = sprintf(' %0.2f, %0.2f, %0.2f (%0.2f)',A, mean(A));
          h = text(xyz(iAtom,1),xyz(iAtom,2),xyz(iAtom,3),str,'Parent',hDisplay);
          set(h,'Fontsize',8,'VerticalAl','bottom','Color',[0 0.6 0]);
        end
        if plotHFframe
          hfarrowLength=0.4;
          V = hfarrowLength*V;
          dir1 = V(:,1);
          dir2 = V(:,2);
          dir3 = V(:,3);
          Origin = thisdata.xyz(iAtom,:);
          
          % principal directions
          h = [];
          h(1) = line(Origin(1)+[-1 1]*dir1(1),Origin(2)+[-1 1]*dir1(2),Origin(3)+[-1 1]*dir1(3),'Color','r','Parent',hDisplay);
          h(2) = line(Origin(1)+[-1 1]*dir2(1),Origin(2)+[-1 1]*dir2(2),Origin(3)+[-1 1]*dir2(3),'Color',[0 0.5 0],'Parent',hDisplay);
          h(3) = line(Origin(1)+[-1 1]*dir3(1),Origin(2)+[-1 1]*dir3(2),Origin(3)+[-1 1]*dir3(3),'Color','b','Parent',hDisplay);
          set(h,'LineWidth',0.5);
          
          % principal values
          if hyperfineDisplay && aboveThreshold
            format = ' %+0.2f';
            h(1) = text(Origin(1)+dir1(1),Origin(2)+dir1(2),Origin(3)+dir1(3),sprintf(format,A(1)),'Color','r','Parent',hDisplay);
            h(2) = text(Origin(1)+dir2(1),Origin(2)+dir2(2),Origin(3)+dir2(3),sprintf(format,A(2)),'Color',[0 0.5 0],'Parent',hDisplay);
            h(3) = text(Origin(1)+dir3(1),Origin(2)+dir3(2),Origin(3)+dir3(3),sprintf(format,A(3)),'Color','b','Parent',hDisplay);
            set(h,'FontSize',8);
          end
          
          % ellipsoids
          N = 11;
          r = abs(A);
          r = r/max(r);
          r = max(r,0.1)*hfarrowLength*1.8;
          theta = linspace(0,pi,N);
          phi = linspace(0,2*pi,2*N);
          [theta,phi] = meshgrid(theta,phi);
          xhf = r(1)*cos(phi).*sin(theta);
          yhf = r(2)*sin(phi).*sin(theta);
          zhf = r(3)*cos(theta);          
          vecs = V*[xhf(:) yhf(:) zhf(:)].';
          xhf = reshape(vecs(1,:),2*N,[]);
          yhf = reshape(vecs(2,:),2*N,[]);
          zhf = reshape(vecs(3,:),2*N,[]);
          c = sqrt(xhf.^2+yhf.^2+zhf.^2);
          hs = surface(xhf+Origin(1),yhf+Origin(2),zhf+Origin(3),c,'Parent',hDisplay);
          set(hs,'FaceColor','interp','Clipping','off');

        end
      end
      
      % Quadrupole
      %---------------------------------------------------------------
      if quadrupoleDisplay
        if ~isempty(thisdata.efg{iAtom})
          %Q = eig(efg{iAtom});
          %h = text(xyz(iAtom,1),xyz(iAtom,2),xyz(iAtom,3),sprintf('%0.3g\n%0.3g\n%0.3g',Q));
          h = text(xyz(iAtom,1),xyz(iAtom,2),xyz(iAtom,3),sprintf(' %+0.3g, %0.3g',thisdata.eeqQ(iAtom),thisdata.eta(iAtom)),'Parent',hDisplay);
          set(h,'Fontsize',8,'VerticalAl','top','Color',[0.48 0.06 0.89]);
        end
      end
    end
    
    set(get(hDisplay,'Children'),'Clipping','off');
    
    %light;
    %lighting phong;
    set(findobj(hDisplay,'Type','surface'),...
      'AmbientStrength',0.7);
    
    rotate3d(hDisplay,'on');
    if isfield(thisdata,'azel')
      view(hDisplay,thisdata.azel);
    end
  end


  function data = parseORCAfile(L)
    
    nLines = numel(L);
    
    % Extract contents of ORCA input file
    %---------------------------------------------------------
    k = 1;
    while L{k}(1)~='|', k = k+1; end
    k1 = k - 1;
    while L{k}(1)=='|', k = k+1; end
    k2 = k - 1;
    data.InputFile = char(L(k1:k2));
    
    % Determine whether it's a multiple structure file
    %---------------------------------------------------------
    MultiXYZHeader = '* Multiple XYZ Scan Calculation *';
    multiXYZ = false;
    startIdx = k;
    nStructures = 1;
    while (k<=nLines)
      if strcmp(L{k},MultiXYZHeader), multiXYZ = true; break; end
      k = k + 1;
    end
    if multiXYZ
      multiStepTitle = 'MULTIPLE XYZ STEP';
      startIdx = find(strncmp(multiStepTitle,L,numel(multiStepTitle)));
      nStructures = numel(startIdx);
    end
    
    for iStructure = 1:nStructures
      
      kstart = startIdx(iStructure);
      if (iStructure<nStructures)
        kend = startIdx(iStructure+1)-1;
      else
        kend = nLines;
      end

      % Extract cartesian coordinates in angstrom
      %---------------------------------------------------------
      CoordinateHeader = 'CARTESIAN COORDINATES (ANGSTROEM)';
      for k = kstart:kend
        if strcmp(L{k},CoordinateHeader), break; end;
      end
      k = k+2;
      iAtom = 1;
      elementSymbols = ['H HeLiBeB C N O F NeNaMgAlSiP S ClAr'...
        'K CaScTiV CrMnFeCoNiCuZnGaGeAsSeBrKr'...
        'RbSrY ZrNbMoTcRuRhPdAgCdInSnSbTeI Xe'...
        'CsBaLaCePrNdPmSmEuGdTbDyHoErTmYbLuHfTaW ReOsIrPtAuHgTlPbBiPoAtRn'...
        'FrRaAcThPaU NpPuAmCmBkCfEsFmMdNoLrRfDbSgBhHsMtDsRgCn'];
      clear xyz Element
      while L{k}(1)~='-'
        xyz(iAtom,:) = sscanf(L{k},'%*s %f %f %f');
        Element{iAtom} = sscanf(L{k},'%s',1);
        if length(Element{iAtom})==1
          i = strfind(elementSymbols,[Element{iAtom} ' ']);
        else
          i = strfind(elementSymbols,Element{iAtom});
        end
        if ~isempty(i)
          NucId(iAtom) = (i+1)/2;
        else
          error('Unknown element ''%s''.',Element{iAtom});
        end
        k = k+1;
        iAtom = iAtom + 1;
      end
      nAtoms = size(xyz,1);
      data(iStructure).nAtoms = nAtoms;
      data(iStructure).NucId = NucId;
      data(iStructure).Element = Element;
      data(iStructure).xyz = xyz;
      
      % Mulliken atomic charges and spin populations
      %-----------------------------------------------------------------
      % versions prior to 2.7
      MullikenHeader26 = 'MULLIKEN ATOMIC CHARGES AND SPIN DENSITIES';
      % version 2.7 and later
      MullikenHeader = 'MULLIKEN ATOMIC CHARGES AND SPIN POPULATIONS';
      MullikenSection = false;
      for k = kstart:kend
        if strcmp(L{k},MullikenHeader26) || strcmp(L{k},MullikenHeader)
          MullikenSection = true;
          break
        end
      end
      if MullikenSection
        clear Mulliken
        k = k+2;
        for iAtom = 1:nAtoms
          Mulliken(iAtom,:) = sscanf(L{k+iAtom-1}(9:end),'%f %f').';
        end
      else
        Mulliken = zeros(0,2);
        fprintf('No Mulliken analysis found for structure %2d of %d.\n',iStructure,nStructures);
      end
      data(iStructure).MullikenCharge = Mulliken(:,1);
      data(iStructure).MullikenSpin = Mulliken(:,2);
      
      % g matrix
      %-----------------------------------------------------------------
      gMatrixHeader = 'ELECTRONIC G-MATRIX';
      gMatrixData = false;
      for k = kstart:kend
        if strcmp(L{k},gMatrixHeader), gMatrixData = true; break; end
      end
      
      data(iStructure).g = [];
      data(iStructure).g_ = [];
      data(iStructure).gpv = [];
      data(iStructure).gpa = [];
      
      if gMatrixData
        k = k+3;
        % read raw asymmetric g matrix
        g_asym(1,:) = sscanf(L{k+0},'%f %f %f').';
        g_asym(2,:) = sscanf(L{k+1},'%f %f %f').';
        g_asym(3,:) = sscanf(L{k+2},'%f %f %f').';
        g_sym = (g_asym.'*g_asym)^(1/2);
        g_sym = (g_sym+g_sym.')/2; % symmetrize numerically
        
        [V,g] = eig(g_sym);
        if det(V)<0, V = V(:,[1 3 2]); g = g([1 3 2],[1 3 2]); end
        gpv = diag(g).';
        gpa = eulang(V);
        
        data(iStructure).g_ = g_asym;
        data(iStructure).g = g_sym;
        data(iStructure).gpv = gpv;
        data(iStructure).gpa = gpa;
      end
      
      % Hyperfine and efg data
      %-----------------------------------------------------------------
      nuclearHeader = 'ELECTRIC AND MAGNETIC HYPERFINE STRUCTURE';
      HyperfineData = false;
      for k = kstart:kend
         if strcmp(L{k},nuclearHeader), HyperfineData = true; break; end
      end
      
      hfc = cell(1,nAtoms);
      efg = cell(1,nAtoms);
      eeqQ = zeros(1,nAtoms);
      eeqQscaled = zeros(1,nAtoms);
      eta = zeros(1,nAtoms);
      
      if HyperfineData
        iAtom = 0;
        hfc = cell(1,nAtoms);
        efg = cell(1,nAtoms);
        while k<=kend
          switch L{k}(1:7)
            case 'Nucleus'
              iAtom = sscanf(L{k}(8:end),'%d',1)+1;
            case 'Raw HFC'
              idx = k+1;
              if strncmp(L{k+1}(1:3),'---',3), idx = k+2; end
              hfc_(1,:) = sscanf(L{idx},'%f %f %f');
              hfc_(2,:) = sscanf(L{idx+1},'%f %f %f').';
              hfc_(3,:) = sscanf(L{idx+2},'%f %f %f').';
              hfc{iAtom} = hfc_;
              k = k+3;
            case 'Raw EFG'
              efg_(1,:) = sscanf(L{k+1},'%f %f %f');
              efg_(2,:) = sscanf(L{k+2},'%f %f %f').';
              efg_(3,:) = sscanf(L{k+3},'%f %f %f').';
              efg{iAtom} = efg_;
              k = k+3;
            case 'e**2qQ '
              eeqQ(iAtom) = sscanf(L{k}(21:end),'%f',1);
            case 'e**2qQ/'
              eeqQscaled(iAtom) = sscanf(L{k}(21:end),'%f',1);
            case 'eta    '
              eta(iAtom) = sscanf(L{k}(21:end),'%f',1);
          end
          k = k+1;
        end
      end
      
      data(iStructure).hfc = hfc;
      data(iStructure).efg = efg;
      data(iStructure).eeqQ = eeqQ;
      data(iStructure).eeqQscaled = eeqQscaled;
      data(iStructure).eta = eta;
      
      PrintSys = true;
      Sys = struct;
      if PrintSys
        if gMatrixData
          Sys.g = data(iStructure).gpv;
          Sys.gpa = data(iStructure).gpa;
        end
      end
      idx = 1;
      for k=1:numel(hfc)
        A = data(iStructure).hfc{k};
        if isempty(A), continue; end
        [V,A] = eig(A); A = diag(A).';
        if det(V)<0, V = V(:,[1 3 2]); end
        Apa = eulang(V);
        efg = data(iStructure).efg{k};
        if ~isempty(efg)
          [V,efg] = eig(efg); efg = diag(efg).';
          if det(V)<0, V = V(:,[1 3 2]); end
          Qpa = eulang(V);
          eta = data(iStructure).eta(k);
          eeqQscaled = data(iStructure).eeqQscaled(k);
          P = eeqQscaled*[-(1-eta),-(1+eta),2];
          if PrintSys
            Sys = nucspinadd(Sys,data(iStructure).Element{k},A,Apa,P,Qpa);
          end
        else
          if PrintSys
            Sys = nucspinadd(Sys,data(iStructure).Element{k},A,Apa);
          end
        end
        idx = idx + 1;
      end
    
    end % for iStructure = 1:nStructures
    
    % Assign spin system structure in base workspace
    %-----------------------------------------------------
    assignin('base','Sys',Sys);
    
  end

  function loadButton_callback(~,~)
    persistent filepath
    currdir = pwd;
    if ~isempty(filepath), currdir = pwd; cd(filepath); end
    [filename_, filepath_] = uigetfile(...
      {'*.oof','ORCA output file (*.oof)'},...
      'Load ORCA output file',...
      'MultiSelect','on');
    if (numel(filename_)==1) && (filename_==0), return; end
    filename = filename_;
    filepath = filepath_;
    cd(currdir);

    if ~iscell(filename)
      if (filename==0), return; end
      if ischar(filename), filename = {filename}; end
    end
    
    for iFile=1:numel(filename)
      
      % Read entire file at once
      fullfilename = [filepath filename{iFile}];      
      if exist(fullfilename,'file')
        L = textread(fullfilename,'%s','whitespace','\n'); %#ok
      else
        error('File ''%s'' not found.',fullfilename);
      end
      
      % Verify that it is an ORCA file
      if (numel(L)<2) || ~strcmp(L{2},'* O   R   C   A *')
        error('This is not an ORCA output file.');
      end
      if ~strcmp(L{end-1},'****ORCA TERMINATED NORMALLY****')
        error('ORCA did not terminate normally.');
      end
      
      % Parse data from file
      newdata = parseORCAfile(L);
      nNewStructures = numel(newdata);
      [az,el] = view(hDisplay);
      for iStructure = 1:nNewStructures;
        newdata(iStructure).azel = [az el];
      end
      data = [data newdata];
      assignin('base','data',data);
      
      % Update UI file list
      files = get(hFileList,'String');
      name = filename{iFile};
      name = name(1:end-4);
      if isempty(files), files = {}; end
      if numel(newdata)==1
        files(end+1) = {name};
      else
        for iStructure = 1:nNewStructures
          files(end+1) = {sprintf('%s %d',name,iStructure)};
        end
      end
      set(hFileList,'String',files);
      set(hFileList,'Value',numel(data));
      
    end
    
    displayMolecule(numel(data));

  end

  function fileList_callback(~,~)
    idx = get(hFileList,'Value');
    displayMolecule(idx);
  end

  function updatedisplay_callback(~,~)
    displayMolecule;
  end

  function closeallButton_callback(~,~)
    data = [];
    assignin('base','data',data);
    set(hFileList,'String','');
    displayMolecule;
  end

  function closeButton_callback(~,~)
    idx = get(hFileList,'Value');
    files = get(hFileList,'String');
    nFiles = numel(data);
    data(idx) = [];
    assignin('base','data',data);
    files(idx) = [];
    if (idx==nFiles), idx = idx - 1; end
    set(hFileList,'Value',idx);
    set(hFileList,'String',files);
    displayMolecule;
  end

  function settingsButton_callback(~,~)
    if get(hSettingsButton,'Value')==1
      Status = 'on';
    else
      Status = 'off';
    end
    set(hSettingsPanel,'Visible',Status);
  end

  function resizefunction(~,~)
    fig = gcbo;
    posi = get(fig,'Position');
    h = posi(4);
    yy = h-20;
    replace_y = @(hh,y)get(hh,'Position').*[1 0 1 1] + [0 y 0 0];
    set(hLoadButton,'Position',replace_y(hLoadButton,yy));
    set(hCloseButton,'Position',replace_y(hCloseButton,yy));
    set(hCloseAllButton,'Position',replace_y(hCloseAllButton,yy));
    set(hFileList,'Position',replace_y(hFileList,yy-70));
  end

end
