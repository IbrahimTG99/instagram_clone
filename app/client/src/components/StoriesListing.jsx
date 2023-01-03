import { useEffect, useState } from "react";
import { Link } from "react-router-dom";
import Moment from "moment";
import TableHeader from "./TableHelper";
import { getAllStories } from "../api/RorApi";

const StoriesListing = () => {
  const headArr = ["id", "caption", "User", "Created at", ""];
  const [stories, getStories] = useState([]);

  useEffect(() => {
    getstories();
  }, []);

  const getstories = () => {
    getAllStories()
      .then((response) => {
        const stories_data = response.data;
        getStories(stories_data);
      })
      .catch((error) => console.error(`Error ${error}`));
  };

  return (
    <div>
      <table className="table table-dark table-striped">
        <thead>
          <tr>
            <TableHeader headers={headArr} />
          </tr>
        </thead>
        <tbody>
          {stories.map((story) => {
            return (
              <tr key={story.id}>
                <th scope="row">{story.id}</th>
                <td>{story.caption}</td>
                <td>{story.user_id}</td>
                <td>{Moment(story.created_at).format("YYYY-MM-DD HH:mm")}</td>
                <td>
                  <Link to={`/story/${story.id}`}>
                    <button className="btn btn-dark">Show</button>
                  </Link>
                </td>
              </tr>
            );
          })}
        </tbody>
      </table>
    </div>
  );
};

export default StoriesListing;
