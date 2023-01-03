import { useEffect, useState } from "react";
import FollowerData from "./FollowerData";
import TableHeader from "./TableHelper";
import { getAllRelations } from "../api/RorApi";

const RelationListing = () => {
  const headArr = ["User", "Followers"];
  const [relations, getRelations] = useState([]);

  useEffect(() => {
    getrelations();
  }, []);

  const getrelations = () => {
    getAllRelations()
      .then((response) => {
        const relations_data = response.data;
        getRelations(relations_data);
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
        <FollowerData followersList={relations} />
      </table>
    </div>
  );
};

export default RelationListing;
