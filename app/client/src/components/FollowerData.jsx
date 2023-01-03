const FollowerData = (props) => {
  return (
    <tbody>
      {props.followersList.map((user) => {
        return (
          <tr key={user.id}>
            <td>{user.username}</td>
            <td>
              {user.followers.map((follow) => {
                return (
                  <ul key={follow.id}>
                    <li>{follow.username}</li>
                  </ul>
                );
              })}
            </td>
          </tr>
        );
      })}
    </tbody>
  );
};

export default FollowerData;
