import axios from "axios";

axios.defaults.baseURL = "http://localhost:3000";

export function getAllStories() {
  return axios.get("/api/v1/stories");
}

export function getAllRelations() {
  return axios.get("/api/v1/relationships");
}

export function getStoryById(id) {
  return axios.get(`/api/v1/stories/${id}`);
}
