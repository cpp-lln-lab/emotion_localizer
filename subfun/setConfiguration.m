function [cfg] = setConfiguration()
    % (C) Copyright 2022 Remi Gau

    % Initialize configuration

    cfg = struct();

    cfg.dir.root = bids.internal.file_utils(fullfile(fileparts(mfilename('fullpath')), '..'), 'cpath');
    cfg.dir.stimuli = fullfile(cfg.dir.root, 'stimuli');
    cfg.dir.output = fullfile(cfg.dir.root, 'data');

    %% Debug mode settings

    cfg.debug.do = true; % To test the script out of the scanner, skip PTB sync
    cfg.debug.smallWin = false; % To test on a part of the screen, change to 1
    cfg.debug.transpWin = true; % To test with trasparent full size screen

    cfg.verbose = 1;

    cfg.skipSyncTests = 0;

    %% Engine parameters
    cfg.testingDevice = 'mri';
    cfg.eyeTracker.do = false;

    cfg = setMonitor(cfg);

    % Keyboards
    cfg = setKeyboards(cfg);

    % MRI settings
    cfg = setMRI(cfg);

    %% Experiment Design

    % Time between events in secs
    cfg.timing.ISI = 1;

    % Number of seconds after the end all the stimuli before ending the run
    cfg.timing.endDelay = 2;

    % Task parameters
    cfg.bids.MRI.TaskDescription = ['One-back task.', ...
                                    'The participant is asked to press a button, ', ...
                                    'when he/she sees a repeated stimulus.', ...
                                    'This is to force the participant to attend stimulus ', ...
                                    'that is presented.'];
    cfg.bids.MRI.CogAtlasID = 'https://www.cognitiveatlas.org/task/id/tsk_4a57abb949bcd/';
    cfg.bids.MRI.CogPOID = 'http://www.wiki.cogpo.org/index.php?title=N-back_Paradigm';

end

function cfg = setKeyboards(cfg)
    cfg.keyboard.escapeKey = 'ESCAPE';
    cfg.keyboard.responseKey = {'s', 'd', 'space'};
    cfg.keyboard.keyboard = [];
    cfg.keyboard.responseBox = [];

    if strcmpi(cfg.testingDevice, 'mri')
        cfg.keyboard.keyboard = [];
        cfg.keyboard.responseBox = [];
    end
end

function cfg = setMRI(cfg)

    % letter sent by the trigger to sync stimulation and volume acquisition
    cfg.mri.triggerKey = 's';
    cfg.mri.triggerNb = 1;

    cfg.mri.repetitionTime = 1.75;

end

function cfg = setMonitor(cfg)

    % Monitor parameters for PTB
    cfg.color.white = [255 255 255];
    cfg.color.black = [0 0 0];
    cfg.color.red = [255 0 0];
    cfg.color.grey = mean([cfg.color.black; cfg.color.white]);
    cfg.color.background = cfg.color.black;
    cfg.text.color = cfg.color.white;

    % Monitor parameters
    cfg.screen.monitorWidth = 50; % in cm
    cfg.screen.monitorDistance = 40; % distance from the screen in cm

    if strcmpi(cfg.testingDevice, 'mri')
        cfg.screen.monitorWidth = 69.8;
        cfg.screen.monitorDistance = 170;
    end

    cfg.text.size = 28;

end
