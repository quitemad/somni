class ApiConstants {
  // static const baseUrl = 'http://10.0.2.2:8080';
  static const baseUrl = 'http://localhost:8080';

  // Auth
  static const login = '/api/auth/login';
  static const register = '/api/auth/register';
  static const me = '/api/auth/me';
  static const logout = '/api/auth/logout';

  // Sleep
  static const sleep = '/api/sleep';
  static const lastSleep = '/api/sleep/last';

  // Dashboard
  static const dashboard = '/api/dashboard';

// Notes / Tasks / Daily metrics / AI etc (add as needed)
  static const dailyMetrics = '/api/daily-metrics/{date}';

//Calendar
  static const calendarMonth = '/api/calendar/month';
  static const calendarDay = '/api/calendar/day';
  /// Get month calendar (sleep score, indicators per day)
  /// GET /calendar?year=YYYY&month=MM
  static const String calendar = '/api/calendar/month';

  /// Get details for a specific day
  /// GET /calendar/day?date=YYYY-MM-DD
  static const String calendarDayDetails = '/api/calendar/day';
  static const String notes = '/api/notes';
  static const String tasks = '/api/tasks';
  // Stress
  static const String stressFromImage = '/api/ai/stress-from-image';
//Chatbot
  static const chatbotSessionStart = '/api/chatbot/session/start';
  static const chatbotSessionAnswer = '/api/chatbot/session/answer';
  static const chatbotSession = '/api/chatbot/session/{sessionId}';

  static const  musicPrediction ='/api/user/music';
  static const  sleepDisorder ='/api/ai/sleep-disorder';


}