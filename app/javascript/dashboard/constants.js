export default {
  APP_BASE_URL: '/',
  get apiURL() {
    return `${this.APP_BASE_URL}/`;
  },
  GRAVATAR_URL: 'https://www.gravatar.com/avatar/',
  ASSIGNEE_TYPE_SLUG: {
    MINE: 0,
    UNASSIGNED: 1,
    OPEN: 0,
  },
};
