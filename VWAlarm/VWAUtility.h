//
//  VWAUtility.h
//  VWAlarm1
//
//  Created by KIMSEONGTAN on 2015. 5. 5..
//  Copyright (c) 2015년 vwa. All rights reserved.
//

#ifndef VWAlarm1_VWAUtility_h
#define VWAlarm1_VWAUtility_h


#pragma mark - STORYBOARD ID
// alarm
#define ALARM_STORYBOARD_ID_ALARM                                       @"AlarmVC"
#define ALARM_STORYBOARD_ID_ALARM_DETAILNAVI                            @"AlarmDetailNavi"
#define ALARM_STORYBOARD_ID_ALARM_DETAILNAVI_DETAIL                     @"AlarmDetailVC"
#define ALARM_STORYBOARD_ID_ALARM_DETAILNAVI_DETAIL_OPTION              @"AlarmDetailOptionVC"
// Weather
#define WEATHER_STORYBOARD_ID_WEATHER                                   @"WeatherVC"
#define WEATHER_STORYBOARD_ID_WEATHER_DETAILNAVI                        @"WeatherDetailNavi"
#define WEATHER_STORYBOARD_ID_WEATHER_DETAILNAVI_DETAIL                 @"WeatherDetailVC"
#define WEATHER_STORYBOARD_ID_WEATHER_DETAILNAVI_DETAIL_OPTION          @"WeatherDetailOptionVC"

#pragma mark - CELL INDENTIFIER
// alarm
#define ALARM_CELL_IDENTIFIER_ALARM                                     @"AlarmCell"
#define ALARM_CELL_IDENTIFIER_REPEAT                                    @"AlarmRepeatCell"
#define ALARM_CELL_IDENTIFIER_DELETE                                    @"AlarmDeleteCell"
#define ALARM_CELL_IDENTIFIER_LABEL                                     @"AlarmLabelCell"
#define ALARM_CELL_IDENTIFIER_SOUND                                     @"AlarmSoundCell"
#define ALARM_CELL_IDENTIFIER_SONOOZE                                   @"AlarmSnoozeCell"
// alarm detail
#define ALARM_DETAIL_OPTION_CELL_IDENTIFIER_REPEAT                      @"repeatCell"
#define ALARM_DETAIL_OPTION_CELL_IDENTIFIER_SNOOSE                      @"snooseCell"
#define ALARM_DETAIL_OPTION_CELL_IDENTIFIER_LABEL                       @"labelCell"
#define ALARM_DETAIL_OPTION_CELL_IDENTIFIER_SOUND                       @"soundCell"
// weather
#define WEATHER_CELL_IDENTIFIER_WEATHER                                 @"WeatherCell"


#pragma mark - DATA
// display
#define SNOOSECELL_TYPE     @[LSTR(@"1分"), LSTR(@"5分"), LSTR(@"10分"), LSTR(@"30分")]
#define REPEATCELL_WEEK     @[LSTR(@"月"), LSTR(@"火"), LSTR(@"水"), LSTR(@"木"), LSTR(@"金"), LSTR(@"土"), LSTR(@"日")]
#define REPEATCELL_WEEK_INDEX(index) REPEATCELL_WEEK[index]

// alram
#define ALARM_CLOCK_AM            @"AM"
#define ALARM_CLOCK_PM            @"PM"
#define ALARM_DEFAULT_TITLE       @"ALARM"
#define ALARM_NONE_TITLE          LSTR(@"なし")

#pragma mark - PARAMETER KEYS
// parameter key
#define ALARM_PARAMETER_KEY_REPEAT              @"repeat"
//#define ALARM_PARAMETER_KEY_REPEAT_INDEXS       @"repeat_indexs"
#define ALARM_PARAMETER_KEY_LABEL               @"label"
#define ALARM_PARAMETER_KEY_SOUND               @"sound"
#define ALARM_PARAMETER_KEY_SOUND_FILENAME      @"sound_filename"
#define ALARM_PARAMETER_KEY_SNOOSE              @"snoose"

// data key
#define ALARM_DATA_KEY                  @"alarm"

// item key
#define ALARM_ITEM_KEY_TITLE            @"title"
#define ALARM_ITEM_KEY_DATE             @"date"
#define ALARM_ITEM_KEY_REPEAT           @"repeat"
#define ALARM_ITEM_KEY_SOUND            @"sound"
#define ALARM_ITEM_KEY_SOUND_FILENAME   @"sound_filename"
#define ALARM_ITEM_KEY_ACTIVE           @"active"
#define ALARM_ITEM_KEY_SNOOSE           @"snoose"

//!!! 뷰태그는 스토리보드에서 tag에 값을 설정해야 함
// item viewWithTag
#define VIEW_WITH_TAG_SNOOSE_SWITCH           111
#define VIEW_WITH_TAG_DELETE_LABEL            111







#endif
