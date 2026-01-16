class ApiConstants {
  static const baseUrl = 'http://10.0.2.2:8080';

  // Auth
  static const login = '/api/auth/login';
  static const register = '/api/auth/register';
  static const me = '/api/auth/me';
  static const logout = '/api/auth/logout'; // <-- add this

  // Sleep
  static const sleep = '/api/sleep';
  static const lastSleep = '/api/sleep/last';

  // Dashboard
  static const dashboard = '/api/dashboard';

// Notes / Tasks / Daily metrics / AI etc (add as needed)
  static const dailyMetrics = '/api/daily-metrics/{date}';
// static const notes = '/api/notes';
// static const tasks = '/api/tasks';
// static const dailyMetrics = '/api/daily-metrics';
// static const aiSleepDisorder = '/api/ai/sleep-disorder';
}