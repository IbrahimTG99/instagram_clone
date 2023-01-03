import { useEffect, useState } from "react";
import { useParams } from "react-router-dom";
import { getStoryById } from "../api/RorApi";

const StoryShow = () => {
  const { id } = useParams();
  const [story, getStory] = useState({});
  const [errorMessage, setErrorMessage] = useState("");

  useEffect(() => {
    const getstory = () => {
      getStoryById(id)
        .then((response) => {
          const story_data = response.data;
          getStory(story_data);
        })
        .catch((error) => setErrorMessage(error.response.data.message));
    };
    getstory();
  }, [id]);

  return errorMessage ? (
    <div className="alert alert-danger text-center">
      <h2>{errorMessage}</h2>
    </div>
  ) : (
    <div>
      <table className="table table-dark">
        <thead>
          <tr>
            <th scope="col">#</th>
            <th scope="col">caption</th>
            <th scope="col">user</th>
            <th scope="col">Created at</th>
            <th scope="col">Image</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <th scope="row">{story.id}</th>
            <td>{story.caption}</td>
            <td>{story.user_id}</td>
            <td>{story.created_at}</td>
            <td>
              <img src={story.url} alt="could not process" className="img" />
            </td>
          </tr>
        </tbody>
      </table>
    </div>
  );
};

export default StoryShow;
