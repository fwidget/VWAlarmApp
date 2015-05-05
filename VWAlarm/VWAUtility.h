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
#define STORYBOARD_ID_ALARM                                             @"AlarmVC"
#define STORYBOARD_ID_ALARM_DETAILNAVI                                  @"AlarmDetailNavi"
#define STORYBOARD_ID_ALARM_DETAILNAVI_DETAIL                           @"AlarmDetailVC"
#define STORYBOARD_ID_ALARM_DETAILNAVI_DETAIL_OPTION                    @"AlarmDetailOptionVC"
// Weather
#define STORYBOARD_ID_WEATHER                                           @"WeatherVC"
#define STORYBOARD_ID_WEATHER_DETAILNAVI                                @"WeatherDetailNavi"
#define STORYBOARD_ID_WEATHER_DETAILNAVI_DETAIL                         @"WeatherDetailVC"
#define STORYBOARD_ID_WEATHER_DETAILNAVI_DETAIL_OPTION                  @"WeatherDetailOptionVC"

#pragma mark - CELL INDENTIFIER
// alarm
#define CELL_IDENTIFIER_ALARM                                           @"AlarmCell"
#define CELL_IDENTIFIER_ALARM_REPEAT                                    @"AlarmRepeatCell"
#define CELL_IDENTIFIER_ALARM_DELETE                                    @"AlarmDeleteCell"
#define CELL_IDENTIFIER_ALARM_LABEL                                     @"AlarmLabelCell"
//#define CELL_IDENTIFIER_ALARM_SOUND                                     @"AlarmSoundCell"
#define CELL_IDENTIFIER_ALARM_SONOOZE                                   @"AlarmSnoozeCell"
// alarm detail
#define CELL_IDENTIFIER_ALARM_DETAIL_OPTION_REPEAT                      @"RepeatCell"
#define CELL_IDENTIFIER_ALARM_DETAIL_OPTION_SNOOSE                      @"SnooseCell"
#define CELL_IDENTIFIER_ALARM_DETAIL_OPTION_LABEL                       @"LabelCell"
#define CELL_IDENTIFIER_ALARM_DETAIL_OPTION_SOUND                       @"SoundCell"
// weather
#define CELL_IDENTIFIER_WEATHER                                         @"WeatherCell"
// setting
#define CELL_IDENTIFIER_SETTING_MAPVIEW                                 @"MapviewCell"
#define CELL_IDENTIFIER_SETTING_SHARE                                   @"ShareCell"
#define CELL_IDENTIFIER_SETTING_DETAIL                                  @"DetailCell"
#define CELL_IDENTIFIER_SETTING_DELETE                                  @"DetailCell"


#pragma mark - DATA
// display
#define SNOOSECELL_TYPE     @[LSTR(@"1分"), LSTR(@"5分"), LSTR(@"10分"), LSTR(@"30分")]
#define REPEATCELL_WEEK     @[LSTR(@"月"), LSTR(@"火"), LSTR(@"水"), LSTR(@"木"), LSTR(@"金"), LSTR(@"土"), LSTR(@"日")]
#define REPEATCELL_WEEK_INDEX(index) REPEATCELL_WEEK[index]

// alram
#define ALARM_CLOCK_AM                                                  @"AM"
#define ALARM_CLOCK_PM                                                  @"PM"
#define ALARM_DEFAULT_TITLE                                             @"ALARM"
#define ALARM_NONE_TITLE                                                LSTR(@"なし")

#pragma mark - PARAMETER KEYS
// parameter key
#define PARAMETER_KEY_ALARM_REPEAT                                      @"repeat"
#define PARAMETER_KEY_ALARM_LABEL                                       @"label"
#define PARAMETER_KEY_ALARM_SOUND_FILENAMES                             @"sound_filenames"
#define PARAMETER_KEY_ALARM_SNOOSE                                      @"snoose"

// data key
#define DATA_KEY_ALARM                                                  @"alarm"

// item key
#define ITEM_KEY_ALARM_TITLE                                            @"title"
#define ITEM_KEY_ALARM_DATE                                             @"date"
#define ITEM_KEY_ALARM_REPEAT                                           @"repeat"
#define ITEM_KEY_ALARM_SOUND_FILENAMES                                  @"sound_filenames"
#define ITEM_KEY_ALARM_ACTIVE                                           @"active"
#define ITEM_KEY_ALARM_SNOOSE                                           @"snoose"

//!!! 뷰태그는 스토리보드에서 tag에 값을 설정해야 함
// item viewWithTag
#define VIEW_WITH_TAG_SNOOSE_SWITCH                                     111
#define VIEW_WITH_TAG_DELETE_LABEL                                      111
#define VIEW_WITH_TAG_DELETE_BUTTON                                     112

// userdefault key
#define LOCATION_KEY                                                    @"location"
#define LOCATION_KEY_NAME                                               @"name"
#define LOCATION_KEY_LATI                                               @"lati"
#define LOCATION_KEY_LONGI                                              @"longi"
#define LOCATION_DIC(name, lati, longi)                                 @{LOCATION_KEY_NAME : name, LOCATION_KEY_LATI : lati, LOCATION_KEY_LONGI : longi}


#pragma mark - SHARE MESSAGE
#define SHARE_MESSAGE_MAIL_TITLE                                        @"あなたに声で教えてくれる天気アプリ"
#define SHARE_MESSAGE_CONTENT                                           @"あなたに声で天気を教えてくれるアプリ"
#define SHARE_MESSAGE_URL                                               @"https://itun.es/i6B34fX"


#endif
